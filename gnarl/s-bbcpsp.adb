------------------------------------------------------------------------------
--                                                                          --
--                  GNAT RUN-TIME LIBRARY (GNARL) COMPONENTS                --
--                                                                          --
--               S Y S T E M . B B . C P U _ S P E C I F I C                --
--                                                                          --
--                                  B o d y                                 --
--                                                                          --
--        Copyright (C) 1999-2002 Universidad Politecnica de Madrid         --
--             Copyright (C) 2003-2005 The European Space Agency            --
--                     Copyright (C) 2003-2021, AdaCore                     --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
------------------------------------------------------------------------------

--  This is the NEORV32 version of this package. It is the upstream RISC-V
--  body (src/s-bbcpsp__riscv.adb) with these changes:
--
--    * the mcause exception code is taken as a whole instead of being masked
--      to 4 bits, so that the NEORV32 fast interrupt requests (codes 16..31)
--      can be dispatched;
--
--    * every interrupt trap except the machine timer is handed to the
--      External_Interrupt_Trap handler with the mcause code as Interrupt_ID
--      (Board_Support simply forwards it to Interrupt_Wrapper);
--
--    * installing the External_Interrupt_Trap handler does not enable
--      mie.MEIE any more: individual sources are enabled by
--      Board_Support.Interrupts.Install_Interrupt_Handler.

with System.Machine_Code; use System.Machine_Code;

package body System.BB.CPU_Specific is

   use type BB.Interrupts.Interrupt_Handler;

   Handlers : array (Trap_Type) of BB.Interrupts.Interrupt_Handler :=
     (others => null);

   procedure Trap_Entry_Asm;
   pragma Import (Asm, Trap_Entry_Asm, "__gnat_trap_entry");

   procedure Trap_Handler (A0, A1, A2, A3, A4, A5, A6, A7 : Register_Word);
   pragma Export (Asm, Trap_Handler, "__gnat_trap_handler");
   --  The arguments A0-7 correspond to the a0-7 registers used for function
   --  arguments in the RISC-V ABI. These registers potentially hold a
   --  meaningful value in case of syscall or semihosting call.

   procedure OS_Abort
     with Import, Convention => Ada, External_Name => "abort", No_Return;
   --  Provided by System.Machine_Reset

   Interrupt_Bit : constant Register_Word := 2**(Register_Word'Size - 1);

   Timer_Interrupt_Code : constant := 7;
   --  Machine timer interrupt

   subtype Interrupt_Code is Register_Word
     range Register_Word (BB.Interrupts.Interrupt_ID'First)
        .. Register_Word (BB.Interrupts.Interrupt_ID'Last);
   --  The codes that can be forwarded as an Interrupt_ID

   ------------------
   -- Trap_Handler --
   ------------------

   procedure Trap_Handler (A0, A1, A2, A3, A4, A5, A6, A7 : Register_Word) is

      pragma Unreferenced (A0, A1, A2, A3, A4, A5, A6);

      Cause : constant Register_Word := Mcause;
      Code  : constant Register_Word := Cause and not Interrupt_Bit;
   begin

      if (Cause and Interrupt_Bit) /= 0 then

         case Code is

            when Timer_Interrupt_Code =>
               if Handlers (Timer_Trap) /= null then
                  Handlers (Timer_Trap) (Timer_Interrupt_Code);
               end if;

            when others =>
               --  Machine software interrupt (3), machine external interrupt
               --  (11) and the fast interrupt requests FIRQ0 .. FIRQ15
               --  (16 .. 31). The source is only enabled in mie once a
               --  handler has been attached, so Interrupt_Wrapper always
               --  finds one.

               if Code in Interrupt_Code
                 and then Handlers (External_Interrupt_Trap) /= null
               then
                  Handlers (External_Interrupt_Trap)
                    (BB.Interrupts.Interrupt_ID (Code));
               else
                  raise Program_Error
                    with "Unhandled Interrupt Trap:" & Code'Img;
               end if;
         end case;

      else
         case Code is
            when 11 => -- Environment call from M-mode

               case A7 is -- Syscall ID
                  when 93 => OS_Abort;
                  when others =>
                     raise Program_Error with "Unhandled syscall:" & A7'Img;
               end case;

            when others =>
               raise Program_Error with "Unhandled trap:" & Code'Img;
         end case;
      end if;
   end Trap_Handler;

   --------------------------
   -- Install_Trap_Handler --
   --------------------------

   procedure Install_Trap_Handler
     (Service_Routine : BB.Interrupts.Interrupt_Handler;
      Trap            : Trap_Type)
   is
   begin

      Handlers (Trap) := Service_Routine;

      case Trap is
         when Timer_Trap =>
            --  Enable the timer trap
            Set_Mie_Bits (Mie_MTIE);
         when External_Interrupt_Trap =>
            --  Nothing to enable here: each source gets its mie bit set when
            --  its handler is installed.
            null;
      end case;

      --  Set the Machine Trap-Vector address and use Direct mode
      Asm ("csrrw x0, mtvec, %0",
           Inputs   => Address'Asm_Input ("r",
                                          Trap_Entry_Asm'Address),
           Volatile => True);

   end Install_Trap_Handler;

   --------------
   -- Read_CSR --
   --------------

   function Read_CSR return Register_Word is
      Val : Register_Word;
   begin
      Asm ("csrr %0, " & Register_Name,
           Outputs  => Register_Word'Asm_Output ("=r", Val),
           Volatile => True);
      return Val;
   end Read_CSR;

   --------------------
   -- Clear_CSR_Bits --
   --------------------

   procedure Clear_CSR_Bits (Bits : Register_Word) is
      Unused : Register_Word;
   begin
      Asm ("csrrc %0, " & Register_Name & ", %1",
           Outputs  => Register_Word'Asm_Output ("=r", Unused),
           Inputs   => Register_Word'Asm_Input ("r", Bits),
           Volatile => True);
   end Clear_CSR_Bits;

   ------------------
   -- Set_CSR_Bits --
   ------------------

   procedure Set_CSR_Bits (Bits : Register_Word) is
      Unused : Register_Word;
   begin
      Asm ("csrrs %0, " & Register_Name & ", %1",
           Outputs  => Register_Word'Asm_Output ("=r", Unused),
           Inputs   => Register_Word'Asm_Input ("r", Bits),
           Volatile => True);
   end Set_CSR_Bits;

end System.BB.CPU_Specific;
