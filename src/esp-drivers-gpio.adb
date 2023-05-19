package body ESP.Drivers.GPIO
is

   type Pin_Mode is (DISABLE, INPUT, OUTPUT, INPUT_OUTPUT,
                     OUTPUT_OD, INPUT_OUTPUT_OD);

   for Pin_Mode use (DISABLE         => 0,
                     INPUT           => 1,
                     OUTPUT          => 2,
                     INPUT_OUTPUT    => 3,
                     OUTPUT_OD       => 6,
                     INPUT_OUTPUT_OD => 7);

   type Pull_Mode is (PULLUP, PULLDOWN, PULLUP_PULLDOWN, FLOATING);

   for Pull_Mode use (PULLUP          => 0,
                      PULLDOWN        => 1,
                      PULLUP_PULLDOWN => 2,
                      FLOATING        => 3);

   type Level is (Low, High) with Size => 32;

   for Level use (Low => 0, High => 1);

   function "not" (L : Level) return Level is
      (case L is
         when Low => High,
         when High => Low);

   function Reset_Pin (N : GPIO_Pin_Num) return ESP.Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "gpio_reset_pin";

   function Set_Direction (N : GPIO_Pin_Num; M : Pin_Mode)
   return ESP.Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "gpio_set_direction";

   function Set_Pull_Mode (N : GPIO_Pin_Num; M : Pull_Mode)
   return ESP.Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "gpio_set_pull_mode";

   function Set_Level (N : GPIO_Pin_Num; L : Level)
   return ESP.Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "gpio_set_level";

   function Get_Level (N : GPIO_Pin_Num) return Level with
      Import,
      Convention => C,
      External_Name => "gpio_get_level";

   function Create (Num  : GPIO_Pin_Num;
                    Mode : HAL.GPIO.GPIO_Config_Mode) return GPIO_Pin
   is
      use type ESP.Error.ESP_Error;
      Pin : GPIO_Pin :=
         GPIO_Pin'(Num, HAL.GPIO.Input, HAL.GPIO.Pull_Up, ESP.Error.OK);
      Dir : Pin_Mode := DISABLE;
   begin
      case Mode is
         when HAL.GPIO.Input =>
            Dir := INPUT;
         when HAL.GPIO.Output =>
            Dir := OUTPUT;
      end case;
      Pin.Error := Reset_Pin (Pin.Num);
      if Pin.Error = ESP.Error.OK then
         Pin.Error := Set_Direction (Pin.Num, Dir);
         Pin.Conf  := Mode;
      end if;
      return Pin;
   end Create;

   function Pin_Num (This : GPIO_Pin) return GPIO_Pin_Num
   is
   begin
      return This.Num;
   end Pin_Num;

   function Error (This : GPIO_Pin) return ESP.Error.ESP_Error
   is
   begin
      return This.Error;
   end Error;

   overriding
   function Support (This : GPIO_Pin;
                     Capa : HAL.GPIO.Capability) return Boolean
   is
   begin
      return Capa in HAL.GPIO.Input .. HAL.GPIO.Pull_Down;
   end Support;

   overriding
   function Mode (This : GPIO_Pin) return HAL.GPIO.GPIO_Mode
   is
   begin
      return This.Conf;
   end Mode;

   overriding
   procedure Set_Mode (This : in out GPIO_Pin;
                       Mode :        HAL.GPIO.GPIO_Config_Mode)
   is
      Dir : Pin_Mode := DISABLE;
   begin
      case Mode is
         when HAL.GPIO.Input =>
            Dir := INPUT;
         when HAL.GPIO.Output =>
            Dir := OUTPUT;
      end case;
      This.Error := Set_Direction (This.Num, Dir);
      This.Conf  := Mode;
   end Set_Mode;

   overriding
   function Pull_Resistor (This : GPIO_Pin) return HAL.GPIO.GPIO_Pull_Resistor
   is
   begin
      return This.Pull;
   end Pull_Resistor;

   overriding
   procedure Set_Pull_Resistor (This : in out GPIO_Pin;
                                Pull :        HAL.GPIO.GPIO_Pull_Resistor)
   is
      P : Pull_Mode;
   begin
      case Pull is
         when HAL.GPIO.Floating =>
            P := FLOATING;
         when HAL.GPIO.Pull_Up =>
            P := PULLUP;
         when HAL.GPIO.Pull_Down =>
            P := PULLDOWN;
      end case;
      This.Error := Set_Pull_Mode (This.Num, P);
   end Set_Pull_Resistor;

   overriding
   function Set (This : GPIO_Pin) return Boolean
   is
   begin
      return Get_Level (This.Num) = High;
   end Set;

   overriding
   procedure Set (This : in out GPIO_Pin)
   is
   begin
      This.Error := Set_Level (This.Num, High);
   end Set;

   overriding
   procedure Clear (This : in out GPIO_Pin)
   is
   begin
      This.Error := Set_Level (This.Num, Low);
   end Clear;

   overriding
   procedure Toggle (This : in out GPIO_Pin)
   is
   begin
      This.Error := Set_Level (This.Num, not Get_Level (This.Num));
   end Toggle;

end ESP.Drivers.GPIO;
