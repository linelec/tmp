PRJ	= simple
#PORT	= usb
PORT	= /dev/ttyACM0
#TARGET	= STK500v2
#TARGET	= avrispmkII
#TARGET	= linuxspi
TARGET	= wiring
BAUD	= 115200
MCU	= atmega2560
#MCU	= avr6
OSC	= 16000000
F_CPU	= 16000000
DEBUG	= dwarf-2

HEX	= ihex
#FUSES	= -U lfuse:w:0x62:m -U hfuse:w:0x99:m -U efuse:w:0xff:m

upload:

	avrdude -v -c $(TARGET) -P $(PORT) -p $(MCU) -D -U flash:w:$(PRJ).hex:i

#install:

#	avrdude -vv -c $(TARGET) -P $(PORT) -p $(UP) -U flash:w:$(PRJ).hex:i

#rfuses:

#	avrdude -vv -c $(TARGET) -P $(PORT) -p $(UP) \
#	-U hfuse:r:-:b -U lfuse:r:-:b -U efuse:r:-:b


#wfuses:
#	avrdude -vv -c avrispmkII -P $(PORT) -p $(UP) $(FUSES)


#erase:
#	avrdude -vv -c avrispmkII -P $(PORT) -p $(UP) -i 5 -e


