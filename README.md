# esp32c3-ada-bindings

The ESP-IDF Ada Binding is intended to provide a binding to the
[ESP-IDF](https://github.com/espressif/esp-idf) from Espressif.

I do not intend to implement extensive bindings by myself. This
project rather aims to bundle the efforts of everyone who is
using Ada on the ESP.

So far the following APIs are included:

 - Debug print via `printf` (may be removed once a runtime
   proper `Ada.Text_IO` implementation is available)
 - Error codes
 - GPIO
 - LED strip

If you want to get started with Ada on the ESP I recommend
taking a look at my [esp32c3-ada template project](https://github.com/jklmnn/esp32c3-ada).
It integrates the required tooling into an [alire](https://github.com/alire-project/alire)
and uses this binding to drive an LED.

So far alire only provides a RiscV compiler and runtime that is also
used in the ESP32C3 example. If you want to test out the ESP8266
I recommend taking a look at my [Xtensa port](https://github.com/jklmnn/gnat-llvm-xtensa)
of [gnat-llvm](https://github.com/AdaCore/gnat-llvm).
