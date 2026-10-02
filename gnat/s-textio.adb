------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                       S Y S T E M . T E X T _ I O                        --
--                                                                          --
--                                 B o d y                                  --
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

--  Minimal polled driver for the NEORV32 UART0 (primary UART), used by
--  Ada.Text_IO. 8N1, no flow control. The baud divisor computation follows
--  neorv32_uart_setup in the NEORV32 software framework.
--
--  The processor clock is read from SYSINFO.CLK, so it cannot disagree with
--  the gateware. The baud rate is the link-time symbol __neorv32_uart0_baud,
--  set by runtime_build.gpr from the UART0_Baud_Rate crate configuration
--  variable (System.Text_IO is No_Elaboration_Code_All and therefore cannot
--  with the configuration package).
--
--  If the SoC was synthesized without UART0 (SYSINFO.SOC.IO_UART0 clear),
--  output is silently discarded and input never becomes ready, instead of
--  trapping on a bus access to an unimplemented device.

with Interfaces;                 use Interfaces;
with Interfaces.NEORV32;         use Interfaces.NEORV32;
with Interfaces.NEORV32.UART0;   use Interfaces.NEORV32.UART0;
with Interfaces.NEORV32.SYSINFO; use Interfaces.NEORV32.SYSINFO;

with System.Storage_Elements;

package body System.Text_IO is

   Baud_Rate_Symbol : constant Character
     with Import, Convention => Asm, External_Name => "__neorv32_uart0_baud";
   --  The value is the symbol's address, see ld/neorv32.ld

   Present : Boolean := False;
   --  True when UART0 is implemented in this SoC

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
      Clock : constant Unsigned_32 := Unsigned_32 (SYSINFO_Periph.CLK);

      Baud_Rate : constant Unsigned_32 :=
        Unsigned_32
          (System.Storage_Elements.To_Integer (Baud_Rate_Symbol'Address));

      Baud_Div : Unsigned_32 := Clock / (2 * Baud_Rate);

      Prsc_Sel : Unsigned_32 := 0;
      --  Index into the clock prescaler table 2, 4, 8, 64, 128, 1024, 2048,
      --  4096 (the step from index 2 to 3 and from 4 to 5 is a factor 8).
   begin
      Present := SYSINFO_Periph.SOC.SYSINFO_SOC_IO_UART0 = 1;

      if Present then
         --  Fit the 10-bit baud divisor

         while Baud_Div >= 16#400# loop
            if Prsc_Sel = 2 or else Prsc_Sel = 4 then
               Baud_Div := Shift_Right (Baud_Div, 3);
            else
               Baud_Div := Shift_Right (Baud_Div, 1);
            end if;
            Prsc_Sel := Prsc_Sel + 1;
         end loop;

         if Baud_Div = 0 then
            Baud_Div := 1;
         end if;

         --  Initialize is called lazily, on the first Ada.Text_IO output,
         --  which may be after the application has configured UART0
         --  interrupts (for example from a protected handler's elaboration).
         --  Keep the IRQ configuration bits, everything else is ours.

         declare
            Old : constant CTRL_Register := UART0_Periph.CTRL;
         begin
            UART0_Periph.CTRL :=
              (UART_CTRL_EN            => 1,
               UART_CTRL_PRSC          =>
                 CTRL_UART_CTRL_PRSC_Field (Prsc_Sel and 7),
               UART_CTRL_BAUD          =>
                 CTRL_UART_CTRL_BAUD_Field ((Baud_Div - 1) and 16#3FF#),
               UART_CTRL_IRQ_RX_NEMPTY => Old.UART_CTRL_IRQ_RX_NEMPTY,
               UART_CTRL_IRQ_RX_FULL   => Old.UART_CTRL_IRQ_RX_FULL,
               UART_CTRL_IRQ_TX_EMPTY  => Old.UART_CTRL_IRQ_TX_EMPTY,
               UART_CTRL_IRQ_TX_NFULL  => Old.UART_CTRL_IRQ_TX_NFULL,
               others                  => <>);
         end;
      end if;

      Initialized := True;
   end Initialize;

   -----------------
   -- Is_Tx_Ready --
   -----------------

   function Is_Tx_Ready return Boolean is
   begin
      return not Present or else UART0_Periph.CTRL.UART_CTRL_TX_NFULL = 1;
   end Is_Tx_Ready;

   -----------------
   -- Is_Rx_Ready --
   -----------------

   function Is_Rx_Ready return Boolean is
   begin
      return Present and then UART0_Periph.CTRL.UART_CTRL_RX_NEMPTY = 1;
   end Is_Rx_Ready;

   ---------
   -- Get --
   ---------

   function Get return Character is
   begin
      return Character'Val (UART0_Periph.DATA.UART_DATA_RTX);
   end Get;

   ---------
   -- Put --
   ---------

   procedure Put (C : Character) is
   begin
      if Present then
         UART0_Periph.DATA :=
           (UART_DATA_RTX => Byte (Character'Pos (C)), others => <>);
      end if;
   end Put;

   ----------------------------
   -- Use_Cr_Lf_For_New_Line --
   ----------------------------

   function Use_Cr_Lf_For_New_Line return Boolean is (True);

end System.Text_IO;
