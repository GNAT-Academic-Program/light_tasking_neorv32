------------------------------------------------------------------------------
--                                                                          --
--                  GNAT RUN-TIME LIBRARY (GNARL) COMPONENTS                --
--                                                                          --
--                S Y S T E M . B B . B O A R D _ S U P P O R T             --
--                                                                          --
--                                  B o d y                                 --
--                                                                          --
--                     Copyright (C) 2016-2021, AdaCore                     --
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
--                                                                          --
------------------------------------------------------------------------------

--  This is the NEORV32 version of this package.
--
--  NEORV32 has no platform-level interrupt controller: interrupt sources are
--  the standard RISC-V machine software/timer/external interrupts plus the
--  16 fast interrupt request channels, all enabled individually through the
--  mie CSR and identified by their mcause code. The runtime offers a single
--  interrupt priority, so masking is entirely done with mstatus.MIE by
--  System.BB.CPU_Primitives and there is nothing to program per level.

with System.Machine_Code;

with System.BB.CPU_Specific;

package body System.BB.Board_Support is

   use type CPU_Specific.Register_Word;

   procedure Interrupt_Trap_Handler (Interrupt : BB.Interrupts.Interrupt_ID);
   --  Called by System.BB.CPU_Specific.Trap_Handler for every interrupt trap
   --  except the machine timer, with the mcause code as Interrupt

   ----------------------------
   -- Interrupt_Trap_Handler --
   ----------------------------

   procedure Interrupt_Trap_Handler (Interrupt : BB.Interrupts.Interrupt_ID)
   is
   begin
      --  Pending flags are cleared at the source by the user handler, there
      --  is no acknowledge to perform here.

      BB.Interrupts.Interrupt_Wrapper (Interrupt);
   end Interrupt_Trap_Handler;

   ----------------------
   -- Initialize_Board --
   ----------------------

   procedure Initialize_Board is
   begin
      --  crt0 cleared mie, so no source is enabled at this point

      CPU_Specific.Install_Trap_Handler
        (Interrupt_Trap_Handler'Access,
         CPU_Specific.External_Interrupt_Trap);
   end Initialize_Board;

   package body Interrupts is

      -------------------------------
      -- Install_Interrupt_Handler --
      -------------------------------

      procedure Install_Interrupt_Handler
        (Interrupt : System.BB.Interrupts.Interrupt_ID;
         Prio      : Interrupt_Priority)
      is
         pragma Unreferenced (Prio);
      begin
         --  All interrupts go to the same trap handler before being
         --  dispatched, so enabling the source in mie is all there is to do.

         CPU_Specific.Set_Mie_Bits (2 ** Natural (Interrupt));
      end Install_Interrupt_Handler;

      ---------------------------
      -- Priority_Of_Interrupt --
      ---------------------------

      function Priority_Of_Interrupt
        (Interrupt : System.BB.Interrupts.Interrupt_ID)
        return System.Any_Priority
      is
         pragma Unreferenced (Interrupt);
      begin
         return Interrupt_Priority'First;
      end Priority_Of_Interrupt;

      ----------------
      -- Power_Down --
      ----------------

      procedure Power_Down is
      begin
         --  Sleep until the next enabled interrupt (the alarm at the latest)

         System.Machine_Code.Asm ("wfi", Volatile => True);
      end Power_Down;

      --------------------------
      -- Set_Current_Priority --
      --------------------------

      procedure Set_Current_Priority (Priority : Integer) is
         pragma Unreferenced (Priority);
      begin
         --  Single interrupt priority: nothing to do at the board level
         null;
      end Set_Current_Priority;

   end Interrupts;

   package body Time is separate;

   package body Multiprocessors is separate;

end System.BB.Board_Support;
