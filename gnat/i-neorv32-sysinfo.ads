--
--  Copyright (C) 2026, AdaCore
--

pragma Style_Checks (Off);

--  This spec has been automatically generated from neorv32.svd


with System;

--  System configuration information memory
package Interfaces.NEORV32.SYSINFO is
   pragma Preelaborate;
   pragma No_Elaboration_Code_All;

   ---------------
   -- Registers --
   ---------------

   subtype MISC_SYSINFO_MISC_IMEM_Field is Interfaces.NEORV32.Byte;
   subtype MISC_SYSINFO_MISC_DMEM_Field is Interfaces.NEORV32.Byte;
   subtype MISC_SYSINFO_MISC_HART_Field is Interfaces.NEORV32.UInt4;
   subtype MISC_SYSINFO_MISC_BOOT_Field is Interfaces.NEORV32.UInt2;
   subtype MISC_SYSINFO_MISC_ITMO_Field is Interfaces.NEORV32.UInt5;
   subtype MISC_SYSINFO_MISC_ETMO_Field is Interfaces.NEORV32.UInt5;

   --  Miscellaneous system configurations
   type MISC_Register is record
      --  Read-only. log2(IMEM size in bytes)
      SYSINFO_MISC_IMEM : MISC_SYSINFO_MISC_IMEM_Field;
      --  Read-only. log2(DMEM size in bytes)
      SYSINFO_MISC_DMEM : MISC_SYSINFO_MISC_DMEM_Field;
      --  Read-only. Number of physical CPU cores
      SYSINFO_MISC_HART : MISC_SYSINFO_MISC_HART_Field;
      --  Read-only. Boot mode configuration select
      SYSINFO_MISC_BOOT : MISC_SYSINFO_MISC_BOOT_Field;
      --  Read-only. log2(internal bus timeout cycles)
      SYSINFO_MISC_ITMO : MISC_SYSINFO_MISC_ITMO_Field;
      --  Read-only. log2(external bus timeout cycles)
      SYSINFO_MISC_ETMO : MISC_SYSINFO_MISC_ETMO_Field;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for MISC_Register use record
      SYSINFO_MISC_IMEM at 0 range 0 .. 7;
      SYSINFO_MISC_DMEM at 0 range 8 .. 15;
      SYSINFO_MISC_HART at 0 range 16 .. 19;
      SYSINFO_MISC_BOOT at 0 range 20 .. 21;
      SYSINFO_MISC_ITMO at 0 range 22 .. 26;
      SYSINFO_MISC_ETMO at 0 range 27 .. 31;
   end record;

   subtype SOC_SYSINFO_SOC_BOOTLOADER_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_XBUS_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IMEM_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_DMEM_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_OCD_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_ICACHE_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_DCACHE_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_SCM_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_OCD_AUTH_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IMEM_ROM_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_TWD_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_DMA_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_GPIO_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_CLINT_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_UART0_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_SPI_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_TWI_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_PWM_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_WDT_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_CFS_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_TRNG_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_SDI_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_UART1_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_NEOLED_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_TRACER_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_GPTMR_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_SLINK_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_IO_ONEWIRE_Field is Interfaces.NEORV32.Bit;
   subtype SOC_SYSINFO_SOC_SIM_Field is Interfaces.NEORV32.Bit;

   --  SoC configuration
   type SOC_Register is record
      --  Read-only. Bootloader implemented
      SYSINFO_SOC_BOOTLOADER : SOC_SYSINFO_SOC_BOOTLOADER_Field;
      --  Read-only. External bus interface implemented
      SYSINFO_SOC_XBUS       : SOC_SYSINFO_SOC_XBUS_Field;
      --  Read-only. Processor-internal instruction memory implemented
      SYSINFO_SOC_IMEM       : SOC_SYSINFO_SOC_IMEM_Field;
      --  Read-only. Processor-internal data memory implemented
      SYSINFO_SOC_DMEM       : SOC_SYSINFO_SOC_DMEM_Field;
      --  Read-only. On-chip debugger implemented
      SYSINFO_SOC_OCD        : SOC_SYSINFO_SOC_OCD_Field;
      --  Read-only. Processor-internal instruction cache implemented
      SYSINFO_SOC_ICACHE     : SOC_SYSINFO_SOC_ICACHE_Field;
      --  Read-only. Processor-internal data cache implemented
      SYSINFO_SOC_DCACHE     : SOC_SYSINFO_SOC_DCACHE_Field;
      --  Read-only. Serial memory controller implemented
      SYSINFO_SOC_SCM        : SOC_SYSINFO_SOC_SCM_Field;
      --  unspecified
      Reserved_8_10          : Interfaces.NEORV32.UInt3;
      --  Read-only. On-chip debugger authentication implemented
      SYSINFO_SOC_OCD_AUTH   : SOC_SYSINFO_SOC_OCD_AUTH_Field;
      --  Read-only. Processor-internal instruction memory implemented as
      --  pre-initialized ROM
      SYSINFO_SOC_IMEM_ROM   : SOC_SYSINFO_SOC_IMEM_ROM_Field;
      --  Read-only. Two-wire device implemented
      SYSINFO_SOC_IO_TWD     : SOC_SYSINFO_SOC_IO_TWD_Field;
      --  Read-only. Direct memory access controller implemented
      SYSINFO_SOC_IO_DMA     : SOC_SYSINFO_SOC_IO_DMA_Field;
      --  Read-only. General purpose input/output port unit implemented
      SYSINFO_SOC_IO_GPIO    : SOC_SYSINFO_SOC_IO_GPIO_Field;
      --  Read-only. Core local interruptor implemented
      SYSINFO_SOC_IO_CLINT   : SOC_SYSINFO_SOC_IO_CLINT_Field;
      --  Read-only. Primary universal asynchronous receiver/transmitter
      --  implemented
      SYSINFO_SOC_IO_UART0   : SOC_SYSINFO_SOC_IO_UART0_Field;
      --  Read-only. Serial peripheral interface implemented
      SYSINFO_SOC_IO_SPI     : SOC_SYSINFO_SOC_IO_SPI_Field;
      --  Read-only. Two-wire interface implemented
      SYSINFO_SOC_IO_TWI     : SOC_SYSINFO_SOC_IO_TWI_Field;
      --  Read-only. Pulse-width modulation unit implemented
      SYSINFO_SOC_IO_PWM     : SOC_SYSINFO_SOC_IO_PWM_Field;
      --  Read-only. Watchdog timer implemented
      SYSINFO_SOC_IO_WDT     : SOC_SYSINFO_SOC_IO_WDT_Field;
      --  Read-only. Custom functions subsystem implemented
      SYSINFO_SOC_IO_CFS     : SOC_SYSINFO_SOC_IO_CFS_Field;
      --  Read-only. True random number generator implemented
      SYSINFO_SOC_IO_TRNG    : SOC_SYSINFO_SOC_IO_TRNG_Field;
      --  Read-only. Serial data interface implemented
      SYSINFO_SOC_IO_SDI     : SOC_SYSINFO_SOC_IO_SDI_Field;
      --  Read-only. Secondary universal asynchronous receiver/transmitter
      --  implemented
      SYSINFO_SOC_IO_UART1   : SOC_SYSINFO_SOC_IO_UART1_Field;
      --  Read-only. NeoPixel-compatible smart LED interface implemented
      SYSINFO_SOC_IO_NEOLED  : SOC_SYSINFO_SOC_IO_NEOLED_Field;
      --  Read-only. Execution tracer implemented
      SYSINFO_SOC_IO_TRACER  : SOC_SYSINFO_SOC_IO_TRACER_Field;
      --  Read-only. General purpose timer implemented
      SYSINFO_SOC_IO_GPTMR   : SOC_SYSINFO_SOC_IO_GPTMR_Field;
      --  Read-only. Stream link interface implemented
      SYSINFO_SOC_IO_SLINK   : SOC_SYSINFO_SOC_IO_SLINK_Field;
      --  Read-only. 1-wire interface controller implemented
      SYSINFO_SOC_IO_ONEWIRE : SOC_SYSINFO_SOC_IO_ONEWIRE_Field;
      --  Read-only. Set if this is a simulation
      SYSINFO_SOC_SIM        : SOC_SYSINFO_SOC_SIM_Field;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for SOC_Register use record
      SYSINFO_SOC_BOOTLOADER at 0 range 0 .. 0;
      SYSINFO_SOC_XBUS       at 0 range 1 .. 1;
      SYSINFO_SOC_IMEM       at 0 range 2 .. 2;
      SYSINFO_SOC_DMEM       at 0 range 3 .. 3;
      SYSINFO_SOC_OCD        at 0 range 4 .. 4;
      SYSINFO_SOC_ICACHE     at 0 range 5 .. 5;
      SYSINFO_SOC_DCACHE     at 0 range 6 .. 6;
      SYSINFO_SOC_SCM        at 0 range 7 .. 7;
      Reserved_8_10          at 0 range 8 .. 10;
      SYSINFO_SOC_OCD_AUTH   at 0 range 11 .. 11;
      SYSINFO_SOC_IMEM_ROM   at 0 range 12 .. 12;
      SYSINFO_SOC_IO_TWD     at 0 range 13 .. 13;
      SYSINFO_SOC_IO_DMA     at 0 range 14 .. 14;
      SYSINFO_SOC_IO_GPIO    at 0 range 15 .. 15;
      SYSINFO_SOC_IO_CLINT   at 0 range 16 .. 16;
      SYSINFO_SOC_IO_UART0   at 0 range 17 .. 17;
      SYSINFO_SOC_IO_SPI     at 0 range 18 .. 18;
      SYSINFO_SOC_IO_TWI     at 0 range 19 .. 19;
      SYSINFO_SOC_IO_PWM     at 0 range 20 .. 20;
      SYSINFO_SOC_IO_WDT     at 0 range 21 .. 21;
      SYSINFO_SOC_IO_CFS     at 0 range 22 .. 22;
      SYSINFO_SOC_IO_TRNG    at 0 range 23 .. 23;
      SYSINFO_SOC_IO_SDI     at 0 range 24 .. 24;
      SYSINFO_SOC_IO_UART1   at 0 range 25 .. 25;
      SYSINFO_SOC_IO_NEOLED  at 0 range 26 .. 26;
      SYSINFO_SOC_IO_TRACER  at 0 range 27 .. 27;
      SYSINFO_SOC_IO_GPTMR   at 0 range 28 .. 28;
      SYSINFO_SOC_IO_SLINK   at 0 range 29 .. 29;
      SYSINFO_SOC_IO_ONEWIRE at 0 range 30 .. 30;
      SYSINFO_SOC_SIM        at 0 range 31 .. 31;
   end record;

   subtype CACHE_SYSINFO_CACHE_BLOCK_SIZE_Field is Interfaces.NEORV32.UInt4;
   subtype CACHE_SYSINFO_CACHE_I_NUM_BLOCKS_Field is Interfaces.NEORV32.UInt4;
   subtype CACHE_SYSINFO_CACHE_D_NUM_BLOCKS_Field is Interfaces.NEORV32.UInt4;
   subtype CACHE_YSINFO_CACHE_UC_BEGIN_Field is Interfaces.NEORV32.UInt4;
   subtype CACHE_SYSINFO_CACHE_BURSTS_EN_Field is Interfaces.NEORV32.Bit;

   --  Cache configuration
   type CACHE_Register is record
      --  Read-only. log2(Block size in bytes)
      SYSINFO_CACHE_BLOCK_SIZE   : CACHE_SYSINFO_CACHE_BLOCK_SIZE_Field;
      --  Read-only. log2(Number of i-cache blocks)
      SYSINFO_CACHE_I_NUM_BLOCKS : CACHE_SYSINFO_CACHE_I_NUM_BLOCKS_Field;
      --  Read-only. log2(Number of d-cache blocks)
      SYSINFO_CACHE_D_NUM_BLOCKS : CACHE_SYSINFO_CACHE_D_NUM_BLOCKS_Field;
      --  Read-only. start of uncache address space (256MB page)
      YSINFO_CACHE_UC_BEGIN      : CACHE_YSINFO_CACHE_UC_BEGIN_Field;
      --  Read-only. burst transfers enabled
      SYSINFO_CACHE_BURSTS_EN    : CACHE_SYSINFO_CACHE_BURSTS_EN_Field;
      --  unspecified
      Reserved_17_31             : Interfaces.NEORV32.UInt15;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for CACHE_Register use record
      SYSINFO_CACHE_BLOCK_SIZE   at 0 range 0 .. 3;
      SYSINFO_CACHE_I_NUM_BLOCKS at 0 range 4 .. 7;
      SYSINFO_CACHE_D_NUM_BLOCKS at 0 range 8 .. 11;
      YSINFO_CACHE_UC_BEGIN      at 0 range 12 .. 15;
      SYSINFO_CACHE_BURSTS_EN    at 0 range 16 .. 16;
      Reserved_17_31             at 0 range 17 .. 31;
   end record;

   -----------------
   -- Peripherals --
   -----------------

   --  System configuration information memory
   type SYSINFO_Peripheral is record
      --  Processor clock speed in Hz
      CLK   : aliased Interfaces.NEORV32.UInt32;
      --  Miscellaneous system configurations
      MISC  : aliased MISC_Register;
      --  SoC configuration
      SOC   : aliased SOC_Register;
      --  Cache configuration
      CACHE : aliased CACHE_Register;
   end record
     with Volatile;

   for SYSINFO_Peripheral use record
      CLK   at 16#0# range 0 .. 31;
      MISC  at 16#4# range 0 .. 31;
      SOC   at 16#8# range 0 .. 31;
      CACHE at 16#C# range 0 .. 31;
   end record;

   --  System configuration information memory
   SYSINFO_Periph : aliased SYSINFO_Peripheral
     with Import, Address => SYSINFO_Base;

end Interfaces.NEORV32.SYSINFO;
