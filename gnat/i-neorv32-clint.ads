--
--  Copyright (C) 2026, AdaCore
--

pragma Style_Checks (Off);

--  This spec has been automatically generated from neorv32.svd



--  Core local interruptor
package Interfaces.NEORV32.CLINT is
   pragma Preelaborate;
   pragma No_Elaboration_Code_All;

   ---------------
   -- Registers --
   ---------------

   -----------------
   -- Peripherals --
   -----------------

   --  Core local interruptor
   type CLINT_Peripheral is record
      --  Machine software interrupt; hart 0
      MSWI0         : aliased Interfaces.NEORV32.UInt32;
      --  Machine timer compare low word; hart0
      MTIMECMP0_LOW : aliased Interfaces.NEORV32.UInt32;
      --  Machine timer compare low word; hart0
      MTIMECMP0_HI  : aliased Interfaces.NEORV32.UInt32;
      --  Machine timer low word
      MTIME_LOW     : aliased Interfaces.NEORV32.UInt32;
      --  Machine timer high word
      MTIME_HI      : aliased Interfaces.NEORV32.UInt32;
   end record
     with Volatile;

   for CLINT_Peripheral use record
      MSWI0         at 16#0# range 0 .. 31;
      MTIMECMP0_LOW at 16#4000# range 0 .. 31;
      MTIMECMP0_HI  at 16#4004# range 0 .. 31;
      MTIME_LOW     at 16#BFF8# range 0 .. 31;
      MTIME_HI      at 16#BFFC# range 0 .. 31;
   end record;

   --  Core local interruptor
   CLINT_Periph : aliased CLINT_Peripheral
     with Import, Address => CLINT_Base;

end Interfaces.NEORV32.CLINT;
