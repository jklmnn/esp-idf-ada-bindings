with ESP.Error;
with HAL.GPIO;

package ESP.Drivers.GPIO
is

   type GPIO_Pin_Num is (GPIO_NC, GPIO_0, GPIO_1, GPIO_2, GPIO_3, GPIO_4,
                         GPIO_5, GPIO_6, GPIO_7, GPIO_8, GPIO_9, GPIO_10,
                         GPIO_11, GPIO_12, GPIO_13, GPIO_14, GPIO_15, GPIO_16,
                         GPIO_17, GPIO_18, GPIO_19, GPIO_20, GPIO_21) with
      Size => 32;

   type GPIO_Pin is limited new HAL.GPIO.GPIO_Point with private;

   function Create (Num  : GPIO_Pin_Num;
                    Mode : HAL.GPIO.GPIO_Config_Mode) return GPIO_Pin;

   function Pin_Num (This : GPIO_Pin) return GPIO_Pin_Num;

   function Error (This : GPIO_Pin) return ESP.Error.ESP_Error;

   overriding
   function Support (This : GPIO_Pin;
                     Capa : HAL.GPIO.Capability) return Boolean;

   overriding
   function Mode (This : GPIO_Pin) return HAL.GPIO.GPIO_Mode;

   overriding
   procedure Set_Mode (This : in out GPIO_Pin;
                       Mode :        HAL.GPIO.GPIO_Config_Mode);

   overriding
   function Pull_Resistor (This : GPIO_Pin) return HAL.GPIO.GPIO_Pull_Resistor;

   overriding
   procedure Set_Pull_Resistor (This : in out GPIO_Pin;
                                Pull :        HAL.GPIO.GPIO_Pull_Resistor);

   overriding
   function Set (This : GPIO_Pin) return Boolean;

   overriding
   procedure Set (This : in out GPIO_Pin);

   overriding
   procedure Clear (This : in out GPIO_Pin);

   overriding
   procedure Toggle (This : in out GPIO_Pin);

private

   for GPIO_Pin_Num use (GPIO_NC => -1,
                         GPIO_0  =>  0,
                         GPIO_1  =>  1,
                         GPIO_2  =>  2,
                         GPIO_3  =>  3,
                         GPIO_4  =>  4,
                         GPIO_5  =>  5,
                         GPIO_6  =>  6,
                         GPIO_7  =>  7,
                         GPIO_8  =>  8,
                         GPIO_9  =>  9,
                         GPIO_10 => 10,
                         GPIO_11 => 11,
                         GPIO_12 => 12,
                         GPIO_13 => 13,
                         GPIO_14 => 14,
                         GPIO_15 => 15,
                         GPIO_16 => 16,
                         GPIO_17 => 17,
                         GPIO_18 => 18,
                         GPIO_19 => 19,
                         GPIO_20 => 20,
                         GPIO_21 => 21);

   type GPIO_Pin is limited new HAL.GPIO.GPIO_Point with record
      Num   : GPIO_Pin_Num;
      Conf  : HAL.GPIO.GPIO_Config_Mode;
      Pull  : HAL.GPIO.GPIO_Pull_Resistor;
      Error : ESP.Error.ESP_Error;
   end record;

end ESP.Drivers.GPIO;
