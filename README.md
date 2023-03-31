# esp32c3-ada-bindings

The Esp32C3 Ada Binding is intended to provide a binding to the
[ESP-IDF](https://github.com/espressif/esp-idf) from Espressif.
So far the scope is limited to the Esp32C3 however if needed all
devices supported by the ESP-IDF may be included.

I do not intend to implement extensive bindings by myself. This
project rather aims to bundle the efforts of everyone who is
using Ada on the Esp32C3.

So far the following APIs are included:

 - Debug print via `printf` (may be removed once a runtime
   proper `Ada.Text_IO` implementation is available)
 - Error codes
 - GPIO
 - LED strip

If you want to get started with Ada on the Esp32C3 I recommend
taking a look at my [esp32c3-ada template project](https://github.com/jklmnn/esp32c3-ada).
It integrates the required tooling into an [alire](https://github.com/alire-project/alire)
and uses this binding to drive an LED.
