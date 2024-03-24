with System;
with HAL.SPI;
with ESP.Drivers.GPIO;

package ESP.Drivers.SPI.Master
is

   type SPI_Port is limited new HAL.SPI.SPI_Port with private;

   function Create (Host              : SPI_Host_Device;
                    MISO              : ESP.Drivers.GPIO.GPIO_Pin_Num;
                    MOSI              : ESP.Drivers.GPIO.GPIO_Pin_Num;
                    SCLK              : ESP.Drivers.GPIO.GPIO_Pin_Num;
                    Max_Transfer_Size : Natural) return SPI_Port;

   overriding
   function Data_Size (This : SPI_Port) return HAL.SPI.SPI_Data_Size;

   overriding
   procedure Transmit (This    : in out SPI_Port;
                       Data    :        HAL.SPI.SPI_Data_8b;
                       Status  :    out HAL.SPI.SPI_Status;
                       Timeout :        Natural := 1000);

   overriding
   procedure Transmit (This    : in out SPI_Port;
                       Data    :        HAL.SPI.SPI_Data_16b;
                       Status  :    out HAL.SPI.SPI_Status;
                       Timeout :        Natural := 1000);

   overriding
   procedure Receive (This    : in out SPI_Port;
                      Data    :    out HAL.SPI.SPI_Data_8b;
                      Status  :    out HAL.SPI.SPI_Status;
                      Timeout :        Natural := 1000);

   overriding
   procedure Receive (This    : in out SPI_Port;
                      Data    :    out HAL.SPI.SPI_Data_16b;
                      Status  :    out HAL.SPI.SPI_Status;
                      Timeout :        Natural := 1000);

private

   type SPI_Device_Handle is new System.Address;

   Null_Handle : constant SPI_Device_Handle := SPI_Device_Handle (System.Null_Address);

   type SPI_Port is limited new HAL.SPI.SPI_Port with record
      Handle : SPI_Device_Handle;
   end record;

end ESP.Drivers.SPI.Master;
