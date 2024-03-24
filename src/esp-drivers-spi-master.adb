package body ESP.Drivers.SPI.Master
is

   function Create (Host              : SPI_Host_Device;
                    MISO              : ESP.Drivers.GPIO.GPIO_Pin_Num;
                    MOSI              : ESP.Drivers.GPIO.GPIO_Pin_Num;
                    SCLK              : ESP.Drivers.GPIO.GPIO_Pin_Num;
                    Max_Transfer_Size : Natural) return SPI_Port
   is
      SPI_Device : SPI_Device_Handle := Null_Handle;
   begin
      return SPI_Port'(Handle => SPI_Device);
   end Create;

   overriding
   function Data_Size (This : SPI_Port) return HAL.SPI.SPI_Data_Size is
      (HAL.SPI.Data_Size_8b);

   overriding
   procedure Transmit (This    : in out SPI_Port;
                       Data    :        HAL.SPI.SPI_Data_8b;
                       Status  :    out HAL.SPI.SPI_Status;
                       Timeout :        Natural := 1000)
   is
   begin
      null;
   end Transmit;

   overriding
   procedure Transmit (This    : in out SPI_Port;
                       Data    :        HAL.SPI.SPI_Data_16b;
                       Status  :    out HAL.SPI.SPI_Status;
                       Timeout :        Natural := 1000)
   is
   begin
      raise Program_Error;
   end Transmit;

   overriding
   procedure Receive (This    : in out SPI_Port;
                      Data    :    out HAL.SPI.SPI_Data_8b;
                      Status  :    out HAL.SPI.SPI_Status;
                      Timeout :        Natural := 1000)
   is
   begin
      null;
   end Receive;

   overriding
   procedure Receive (This    : in out SPI_Port;
                      Data    :    out HAL.SPI.SPI_Data_16b;
                      Status  :    out HAL.SPI.SPI_Status;
                      Timeout :        Natural := 1000)
   is
   begin
      raise Program_Error;
   end Receive;

end ESP.Drivers.SPI.Master;
