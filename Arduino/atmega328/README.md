# *Arduino on a Breadboard using an ATmega328*


### Variations in signature

ATmega328-PU - 0x1E 0x95 0x14 (PDIP)  
ATmega328P - 0x1E 0x95 0x0F (TQFP)

### Flashing Bootloader

Patch the arduino-1.6.x/hardware/arduino/boards.txt file (Refer the boards.patch)

To burn the bootloader:
1. Upload the ArduinoISP sketch onto your Arduino board /screens/Pro-Mini_ISP.png.  
*Board: Arduino Uno or Pro-Mini  
Processor: ATmega328 (5V, 16 MHz)   
Programmer: AVRISP mkII*
2. Wire up the Arduino board and microcontroller as shown in /screens/bootload-wiring-XTAL.png
3. Connect a LED betwwen IO-13 (PIN-19) and GND
4. Apply settings as shown in /screens/bootload-settings.png  
*Board: ATmega328-PU on breadboard (...)  
Programmer: Arduino as ISP*
5. Run Tools > Burn Bootloader. The LED will continuously blink while and after flashing 
the bootloader (only if successfully done).

### Flashing Sketches

Unwire the Arduino. Make connections as shown in /screens/sketch-upload-connections.png

To Flash Sketches:
1. Apply settings as shown in /screens/sketch-upload-settings.png  
*Board: ATmega328-PU on breadboard (...)  
Programmer: AVRISP mkII*
2. To Upload the sketch, press and hold the reset button. 
3. Hit the upload button on the IDE
4. Release the reset button as soon as characters are dumped on the IDE console.
5. If the signature is inverted (i.e. if it expects ATMega328P signature) use the Arduino Pro-Mini (3.3V, 8MHz)   
setting from Tools->Board menu (blink-twice.png)  
*Board: Arduino Uno or Pro-Mini  
Processor: ATmega328 (3.3V, 8 MHz)  
Programmer: AVRISP mkII*


### Handling Signature Problems (Obsolete)

###### First time bootloader flashing. The problem was solved using the below method.

```
avrdude:
		Expected signature for ATmega328P is 1E 95 0F         
		Double check chip, or use -F to override this check. Wrong microcontroller found.  
		Did you select the right board from the Tools > Board menu?
```

*Most likely cause:   
            You have an ATmega328-PU chip instead of an ATmega328P-PU chip.  
			Device signature for ATMEGA328-PU = 0x 1E 95 14  
			Signature for ATMEGA328P is 1E 95 0F*

If this is your problem, you can probably temporarily change the "uno.build.mcu" in boards.txt
from "atmega328p" to just "atmega328" and burn the bootloader

I Just changed the following -> diecimila.menu.cpu.atmega328.build.mcu=atmega328p to atmega328 
(check flash-bootloader-success.log). No changes were made in the avrdude.conf file. 

###### Patching avrdude.conf file to match the signature of the chip
	patch ./hardware/tools/avr/etc/avrdude.conf /patches/avrdude_conf.patch


### Command line fuse bytes, Arduino must be connected to ATmega328 (Risky business) 


##### Reading Fuse bytes

```
$ /usr/src/arduino-1.6.7/hardware/tools/avr/bin/avrdude -C/usr/src/arduino-1.6.7/hardware/tools/avr/etc/avrdude.conf -patmega328 -b19200 -P/dev/ttyUSB0 -cstk500v1 -v
```

##### Writing fuse bytes for 16 MHz External Oscillator

```
$ /usr/src/arduino-1.6.7/hardware/tools/avr/bin/avrdude -C/usr/src/arduino-1.6.7/hardware/tools/avr/etc/avrdude.conf -v -patmega328 -cstk500v1 -P/dev/ttyUSB0 -b19200 -e -Ulock:w:0x3F:m -Uefuse:w:0x05:m -Uhfuse:w:0xDA:m -Ulfuse:w:0xFF:m 
```

##### Writing fuse bytes for 8 MHz Internal Oscillator

```	
$ /usr/src/arduino-1.6.7/hardware/tools/avr/bin/avrdude -C/usr/src/arduino-1.6.7/hardware/tools/avr/etc/avrdude.conf -v -patmega328p -cstk500v1 -P/dev/ttyUSB0 -b19200 -e -Ulock:w:0x3F:m -Uefuse:w:0x05:m -Uhfuse:w:0xDA:m	-Ulfuse:w:0xE2:m 
```

I used a -F option on the terminal to force it to flash the bootloader (or is this only the fuse bits).

### Refrences

[Flashing bootloader](http://forum.arduino.cc/index.php?topic=58670.15)  
[Fuse bytes using terminal](http://heliosoph.mit-links.info/arduinoisp-reading-writing-fuses-atmega328p/)   
[Separating out ATMega328 and ATMega328P conf settings](http://www.instructables.com/id/Burning-the-Bootloader-on-ATMega328-using-Arduino-/?ALLSTEPS)
