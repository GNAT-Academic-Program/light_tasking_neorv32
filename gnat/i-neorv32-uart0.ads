--
--  Copyright (C) 2026, AdaCore
--

pragma Style_Checks (Off);

--  This spec has been automatically generated from neorv32.svd


with System;

--  Primary universal asynchronous receiver and transmitter
package Interfaces.NEORV32.UART0 is
   pragma Preelaborate;
   pragma No_Elaboration_Code_All;

   ---------------
   -- Registers --
   ---------------

   subtype CTRL_UART_CTRL_EN_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_SIM_MODE_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_HWFC_EN_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_PRSC_Field is Interfaces.NEORV32.UInt3;
   subtype CTRL_UART_CTRL_BAUD_Field is Interfaces.NEORV32.UInt10;
   subtype CTRL_UART_CTRL_RX_NEMPTY_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_RX_FULL_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_TX_EMPTY_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_TX_NFULL_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_IRQ_RX_NEMPTY_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_IRQ_RX_FULL_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_IRQ_TX_EMPTY_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_IRQ_TX_NFULL_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_RX_OVER_Field is Interfaces.NEORV32.Bit;
   subtype CTRL_UART_CTRL_TX_BUSY_Field is Interfaces.NEORV32.Bit;

   --  Control register
   type CTRL_Register is record
      --  UART enable flag
      UART_CTRL_EN            : CTRL_UART_CTRL_EN_Field := 16#0#;
      --  Simulation output override enable, for use in simulation only
      UART_CTRL_SIM_MODE      : CTRL_UART_CTRL_SIM_MODE_Field := 16#0#;
      --  Enable RTS/CTS hardware flow-control
      UART_CTRL_HWFC_EN       : CTRL_UART_CTRL_HWFC_EN_Field := 16#0#;
      --  CLock prescaler select
      UART_CTRL_PRSC          : CTRL_UART_CTRL_PRSC_Field := 16#0#;
      --  BAUD rate divisor
      UART_CTRL_BAUD          : CTRL_UART_CTRL_BAUD_Field := 16#0#;
      --  Read-only. RX FIFO not empty
      UART_CTRL_RX_NEMPTY     : CTRL_UART_CTRL_RX_NEMPTY_Field := 16#0#;
      --  Read-only. RX FIFO full
      UART_CTRL_RX_FULL       : CTRL_UART_CTRL_RX_FULL_Field := 16#0#;
      --  Read-only. TX FIFO empty
      UART_CTRL_TX_EMPTY      : CTRL_UART_CTRL_TX_EMPTY_Field := 16#0#;
      --  Read-only. TX FIFO not full
      UART_CTRL_TX_NFULL      : CTRL_UART_CTRL_TX_NFULL_Field := 16#0#;
      --  Fire IRQ if RX FIFO not empty
      UART_CTRL_IRQ_RX_NEMPTY : CTRL_UART_CTRL_IRQ_RX_NEMPTY_Field := 16#0#;
      --  Fire IRQ if RX FIFO full
      UART_CTRL_IRQ_RX_FULL   : CTRL_UART_CTRL_IRQ_RX_FULL_Field := 16#0#;
      --  Fire IRQ if TX FIFO empty
      UART_CTRL_IRQ_TX_EMPTY  : CTRL_UART_CTRL_IRQ_TX_EMPTY_Field := 16#0#;
      --  Fire IRQ if TX FIFO not full
      UART_CTRL_IRQ_TX_NFULL  : CTRL_UART_CTRL_IRQ_TX_NFULL_Field := 16#0#;
      --  unspecified
      Reserved_24_29          : Interfaces.NEORV32.UInt6 := 16#0#;
      --  Read-only. *** This field is modified following a read operation ***.
      --  RX FIFO overflow; clears on CTRL read access
      UART_CTRL_RX_OVER       : CTRL_UART_CTRL_RX_OVER_Field := 16#0#;
      --  Read-only. Transmitter busy or TX FIFO not empty
      UART_CTRL_TX_BUSY       : CTRL_UART_CTRL_TX_BUSY_Field := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for CTRL_Register use record
      UART_CTRL_EN            at 0 range 0 .. 0;
      UART_CTRL_SIM_MODE      at 0 range 1 .. 1;
      UART_CTRL_HWFC_EN       at 0 range 2 .. 2;
      UART_CTRL_PRSC          at 0 range 3 .. 5;
      UART_CTRL_BAUD          at 0 range 6 .. 15;
      UART_CTRL_RX_NEMPTY     at 0 range 16 .. 16;
      UART_CTRL_RX_FULL       at 0 range 17 .. 17;
      UART_CTRL_TX_EMPTY      at 0 range 18 .. 18;
      UART_CTRL_TX_NFULL      at 0 range 19 .. 19;
      UART_CTRL_IRQ_RX_NEMPTY at 0 range 20 .. 20;
      UART_CTRL_IRQ_RX_FULL   at 0 range 21 .. 21;
      UART_CTRL_IRQ_TX_EMPTY  at 0 range 22 .. 22;
      UART_CTRL_IRQ_TX_NFULL  at 0 range 23 .. 23;
      Reserved_24_29          at 0 range 24 .. 29;
      UART_CTRL_RX_OVER       at 0 range 30 .. 30;
      UART_CTRL_TX_BUSY       at 0 range 31 .. 31;
   end record;

   subtype DATA_UART_DATA_RTX_Field is Interfaces.NEORV32.Byte;
   subtype DATA_UART_DATA_RX_FIFO_Field is Interfaces.NEORV32.UInt4;
   subtype DATA_UART_DATA_TX_FIFO_Field is Interfaces.NEORV32.UInt4;

   --  RTX data register
   type DATA_Register is record
      --  *** This field is modified following a read operation ***.
      --  Receive/transmit data
      UART_DATA_RTX     : DATA_UART_DATA_RTX_Field := 16#0#;
      --  Read-only. *** This field is modified following a read operation ***.
      --  log2(RX FIFO size)
      UART_DATA_RX_FIFO : DATA_UART_DATA_RX_FIFO_Field := 16#0#;
      --  Read-only. *** This field is modified following a read operation ***.
      --  log2(TX FIFO size)
      UART_DATA_TX_FIFO : DATA_UART_DATA_TX_FIFO_Field := 16#0#;
      --  unspecified
      Reserved_16_31    : Interfaces.NEORV32.UInt16 := 16#0#;
   end record
     with Volatile_Full_Access, Object_Size => 32,
          Bit_Order => System.Low_Order_First;

   for DATA_Register use record
      UART_DATA_RTX     at 0 range 0 .. 7;
      UART_DATA_RX_FIFO at 0 range 8 .. 11;
      UART_DATA_TX_FIFO at 0 range 12 .. 15;
      Reserved_16_31    at 0 range 16 .. 31;
   end record;

   -----------------
   -- Peripherals --
   -----------------

   --  Primary universal asynchronous receiver and transmitter
   type UART0_Peripheral is record
      --  Control register
      CTRL : aliased CTRL_Register;
      --  RTX data register
      DATA : aliased DATA_Register;
   end record
     with Volatile;

   for UART0_Peripheral use record
      CTRL at 16#0# range 0 .. 31;
      DATA at 16#4# range 0 .. 31;
   end record;

   --  Primary universal asynchronous receiver and transmitter
   UART0_Periph : aliased UART0_Peripheral
     with Import, Address => UART0_Base;

end Interfaces.NEORV32.UART0;
