------------------------------------------------------------------------------
--                                                                          --
--                  GNAT RUN-TIME LIBRARY (GNARL) COMPONENTS                --
--                                                                          --
--                   A D A . I N T E R R U P T S . N A M E S                --
--                                                                          --
--                                  S p e c                                 --
--                                                                          --
--                     Copyright (C) 2019-2021, AdaCore                     --
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

--  This is the NEORV32 version of this package (NEORV32 v1.13.6, see
--  NEORV32_VERSION). The values are the mcause exception codes of the
--  interrupts. The FIRQ channel assignments are those of the NEORV32
--  processor and are the same for every SoC configuration; a channel whose
--  peripheral is not synthesized simply never fires.
--
--  FIRQ pending flags are cleared at the source (for example by reading the
--  UART data register), there is no acknowledge in the runtime. A handler
--  that does not clear its source is re-entered as soon as it returns.

package Ada.Interrupts.Names is

   --  All identifiers in this unit are implementation defined

   pragma Implementation_Defined;

   -----------------------------
   -- Standard RISC-V sources --
   -----------------------------

   Machine_Software_Interrupt : constant Interrupt_ID := 3;
   --  CLINT MSWI (hart 0)

   Machine_External_Interrupt : constant Interrupt_ID := 11;
   --  mext_irq_i top-level pin

   --  The machine timer interrupt (7) is reserved for the runtime

   ----------------------------------
   -- NEORV32 fast interrupt lines --
   ----------------------------------

   FIRQ0_Interrupt  : constant Interrupt_ID := 16;
   FIRQ1_Interrupt  : constant Interrupt_ID := 17;
   FIRQ2_Interrupt  : constant Interrupt_ID := 18;
   FIRQ3_Interrupt  : constant Interrupt_ID := 19;
   FIRQ4_Interrupt  : constant Interrupt_ID := 20;
   FIRQ5_Interrupt  : constant Interrupt_ID := 21;
   FIRQ6_Interrupt  : constant Interrupt_ID := 22;
   FIRQ7_Interrupt  : constant Interrupt_ID := 23;
   FIRQ8_Interrupt  : constant Interrupt_ID := 24;
   FIRQ9_Interrupt  : constant Interrupt_ID := 25;
   FIRQ10_Interrupt : constant Interrupt_ID := 26;
   FIRQ11_Interrupt : constant Interrupt_ID := 27;
   FIRQ12_Interrupt : constant Interrupt_ID := 28;
   FIRQ13_Interrupt : constant Interrupt_ID := 29;
   FIRQ14_Interrupt : constant Interrupt_ID := 30;
   FIRQ15_Interrupt : constant Interrupt_ID := 31;

   -----------------------------------------
   -- Peripheral assignments (v1.13.6)    --
   -----------------------------------------

   --  FIRQ0 is not assigned to any peripheral

   CFS_Interrupt     : constant Interrupt_ID := FIRQ1_Interrupt;
   UART0_Interrupt   : constant Interrupt_ID := FIRQ2_Interrupt;
   UART1_Interrupt   : constant Interrupt_ID := FIRQ3_Interrupt;
   TWD_Interrupt     : constant Interrupt_ID := FIRQ4_Interrupt;
   TRACER_Interrupt  : constant Interrupt_ID := FIRQ5_Interrupt;
   SPI_Interrupt     : constant Interrupt_ID := FIRQ6_Interrupt;
   TWI_Interrupt     : constant Interrupt_ID := FIRQ7_Interrupt;
   GPIO_Interrupt    : constant Interrupt_ID := FIRQ8_Interrupt;
   NEOLED_Interrupt  : constant Interrupt_ID := FIRQ9_Interrupt;
   DMA_Interrupt     : constant Interrupt_ID := FIRQ10_Interrupt;
   SDI_Interrupt     : constant Interrupt_ID := FIRQ11_Interrupt;
   GPTMR_Interrupt   : constant Interrupt_ID := FIRQ12_Interrupt;
   ONEWIRE_Interrupt : constant Interrupt_ID := FIRQ13_Interrupt;
   SLINK_Interrupt   : constant Interrupt_ID := FIRQ14_Interrupt;
   TRNG_Interrupt    : constant Interrupt_ID := FIRQ15_Interrupt;

end Ada.Interrupts.Names;
