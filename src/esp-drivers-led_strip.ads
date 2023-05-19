with System;
with Interfaces;
with Interfaces.C;
with ESP.Error;
with ESP.Drivers.GPIO;

package ESP.Drivers.LED_Strip
is

   type Strip is new System.Address;

   type LED_Pixel_Format is (GRB, GRBW, Format_INVALID) with
      Size => 32;

   for LED_Pixel_Format use (GRB     => 0,
                             GRBW    => 1,
                             Format_INVALID => 2);

   type LED_Model is (WS2812, SK6812, Model_INVALID) with
      Size => 32;

   for LED_Model use (WS2812        => 0,
                      SK6812        => 1,
                      Model_INVALID => 2);

   type LED_Config_Flags is record
      Invert_Out : Boolean;
   end record with
      Size => 32;

   for LED_Config_Flags use record
      Invert_Out at 0 range 0 .. 0;
   end record;

   type LED_Config is record
      GPIO_Num : GPIO.GPIO_Pin_Num;
      Max_Leds : Interfaces.Unsigned_32;
      Format   : LED_Pixel_Format := GRB;
      Model    : LED_Model        := WS2812;
      Flags    : LED_Config_Flags := LED_Config_Flags'(Invert_Out => False);
   end record with
      Convention => C;

   type RMT_Config_Flags is record
      With_DMA : Boolean;
   end record with
      Size => 32;

   for RMT_Config_Flags use record
      With_DMA at 0 range 0 .. 0;
   end record;

   type RMT_Config is record
      Clock_Source      : Interfaces.C.int;
      Resolution        : Interfaces.Unsigned_32;
      Mem_Block_Symbols : Interfaces.C.size_t;
      Flags             : RMT_Config_Flags;
   end record with
      Convention => C;

   function New_RMT_Device (L :     access LED_Config;
                            R :     access RMT_Config;
                            S : out Strip) return Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "led_strip_new_rmt_device";

   function Set_Pixel (S     : Strip;
                       Index : Interfaces.Unsigned_32;
                       Red   : Interfaces.Unsigned_32;
                       Green : Interfaces.Unsigned_32;
                       Blue  : Interfaces.Unsigned_32) return Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "led_strip_set_pixel";


   function Refresh (S : Strip) return Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "led_strip_refresh";

   function Clear (S : Strip) return Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "led_strip_clear";

   function Del (S : Strip) return Error.ESP_Error with
      Import,
      Convention => C,
      External_Name => "led_strip_del";

end ESP.Drivers.LED_Strip;
