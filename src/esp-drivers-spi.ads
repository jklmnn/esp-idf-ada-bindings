private with System;
private with ESP.Drivers.GPIO;

package ESP.Drivers.SPI
is

   type SPI_Host_Device is (
      SPI1_HOST,
      SPI2_HOST,
      SPI3_HOST
   ) with
      Size => 32;

   for SPI_Host_Device use (
      SPI1_HOST => 1,
      SPI2_HOST => 2,
      SPI3_HOST => 3
   );

private

   type Uint8 is mod 2 ** 8 with Size => 8;
   type Uint16 is mod 2 ** 16 with Size => 16;
   type Uint32 is mod 2 ** 32 with Size => 32;

   type SPI_Bus_Config is record
      MOSI              : ESP.Drivers.GPIO.GPIO_Pin_Num := ESP.Drivers.GPIO.GPIO_NC;
      MISO              : ESP.Drivers.GPIO.GPIO_Pin_Num := ESP.Drivers.GPIO.GPIO_NC;
      SCLK              : ESP.Drivers.GPIO.GPIO_Pin_Num := ESP.Drivers.GPIO.GPIO_NC;
      QUADWP            : ESP.Drivers.GPIO.GPIO_Pin_Num := ESP.Drivers.GPIO.GPIO_NC;
      QUADHD            : ESP.Drivers.GPIO.GPIO_Pin_Num := ESP.Drivers.GPIO.GPIO_NC;
      DATA4             : ESP.Drivers.GPIO.GPIO_Pin_Num := ESP.Drivers.GPIO.GPIO_NC;
      DATA5             : ESP.Drivers.GPIO.GPIO_Pin_Num := ESP.Drivers.GPIO.GPIO_NC;
      DATA6             : ESP.Drivers.GPIO.GPIO_Pin_Num := ESP.Drivers.GPIO.GPIO_NC;
      DATA7             : ESP.Drivers.GPIO.GPIO_Pin_Num := ESP.Drivers.GPIO.GPIO_NC;
      Max_Transfer_Size : Integer                       := 0;
      Flags             : Uint32                        := 0;
      Intr_Flags        : Integer                       := 0;
   end record with
      Convention => C;

   type SPI_Mode is (SPI_Mode_0, SPI_Mode_1, SPI_Mode_2, SPI_Mode_3) with
      Size => 32;

   for SPI_Mode use (
      SPI_Mode_0 => 0,
      SPI_Mode_1 => 1,
      SPI_Mode_2 => 2,
      SPI_Mode_3 => 3
   );

   type SPI_Master_Freq is (
      SPI_Master_Freq_8M,
      SPI_Master_Freq_9M,
      SPI_Master_Freq_10M,
      SPI_Master_Freq_11M,
      SPI_Master_Freq_13M,
      SPI_Master_Freq_16M,
      SPI_Master_Freq_20M,
      SPI_Master_Freq_26M,
      SPI_Master_Freq_40M,
      SPI_Master_Freq_80M
   ) with
      Size => 32;

   for SPI_Master_Freq use (
      SPI_Master_Freq_8M  => APB_CLK_FREQ / 10,
      SPI_Master_Freq_9M  => APB_CLK_FREQ / 9,
      SPI_Master_Freq_10M => APB_CLK_FREQ / 8,
      SPI_Master_Freq_11M => APB_CLK_FREQ / 7,
      SPI_Master_Freq_13M => APB_CLK_FREQ / 6,
      SPI_Master_Freq_16M => APB_CLK_FREQ / 5,
      SPI_Master_Freq_20M => APB_CLK_FREQ / 4,
      SPI_Master_Freq_26M => APB_CLK_FREQ / 3,
      SPI_Master_Freq_40M => APB_CLK_FREQ / 2,
      SPI_Master_Freq_80M => APB_CLK_FREQ
   );

   type SPI_Device_Interface_Config is record
      Command_Bits     : Uint8                         := 0;
      Address_Bits     : Uint8                         := 0;
      Dummy_Bits       : Uint8                         := 0;
      Mode             : SPI_Mode                      := SPI_Mode_0;
      Duty_Cycle_Pos   : Uint16                        := 0;
      CS_ENA_Pretrans  : Uint16                        := 0;
      CS_ENA_Posttrans : Uint16                        := 0;
      Clock_Speed_HZ   : SPI_Master_Freq               := SPI_Master_Freq_10M;
      Input_Delay_NS   : Integer                       := 0;
      SPICS_IO_NUM     : ESP.Drivers.GPIO.GPIO_Pin_Num := ESP.Drivers.GPIO.GPIO_NC;
      Pre_CB           : System.Address                := System.Null_Address;
      Post_CB          : System.Address                := System.Null_Address;
   end record with
      Convention => C;

end ESP.Drivers.SPI;
