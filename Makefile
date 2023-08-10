PRJ		= simple
#PORT	= usb
PORT	= /dev/ttyACM0
#PORT	= /dev/ttyUSB0
#PORT	= /dev/ptmx
#TARGET	= STK500v2
#TARGET	= avrispmkII
#TARGET	= linuxspi
TARGET	= wiring
BAUD	= 115200
MCU		= atmega2560
#MCU	= avr6
OSC		= 16000000
F_CPU	= 16000000
DEBUG	= dwarf-2
REMOTE	= table
CC		= avr-gcc
AR		= avr-ar
AS		= avr-as
LD		= avr-ld
OBJCOPY	= avr-objcopy
OBJDUMP	= avr-objdump
STRIP	= avr-strip
SIZE	= avr-size

CFLAGS	=	-Os
#CFLAGS  += -Wa, -adhln -g
#CFLAGS	+=	-Wa,-alh,-L
CFLAGS	+=	-mmcu=$(MCU)
CFLAGS	+=	-DF_CPU=$(OSC)
CFLAGS	+=	-I ~/.opt/include/my
CFLAGS	+=	-Wl,-u,vfprintf -lprintf_flt -lm

include	cflags.mk

#	-mn-flash=num
#CFLAGS	+= -mno-interrupts
#PRINTF_LIB_MIN = -lprintf_min
#SCANF_LIB_MIN = -Wl,-u,vfscanf -lscanf_min
#CFLAGS	+= -std=c99

HEX		= ihex
#ASM	= -x assembler-with-cpp
RM		= rm -f
#FUSES	= -U lfuse:w:0x62:m -U hfuse:w:0x99:m -U efuse:w:0xff:m

OBJECT	= main.o
OBJECT	+= ne.o
OBJECT	+= i2c.o
#OBJECT	+= foo.o
OBJECT	+= moteur.o
OBJECT	+= bidule.o
#OBJECT	+= calcul.o
#OBJECT	+= date.o o watchdog.o osc.o
OBJECT	+= uart.o uart_init.o
OBJECT	+= port.o
#OBJECT	+= irq_int0.o misc.o irq_change.o
#OBJECT	+= max.o math.o
#OBJECT	+= carousel.o
OBJECT	+= serial.o
OBJECT	+= term.o
#OBJECT	+= counter.o
#OBJECT	+= pwm.o
#OBJECT	+= asm.o
#OBJECT	+= bin.o
#OBJECT	+= goo.o
#OBJECT	+= timer.o
OBJECT	+= timer_0.o
OBJECT	+= timer_1.o
OBJECT	+= timer_3.o
OBJECT	+= timer_4.o
OBJECT	+= kernel.o
#OBJECT	+= packet.o
#OBJECT	+= bitstuff.o
#OBJECT	+= bitunstuff.o
#OBJECT	+= spi.o
#OBJECT	+= mcp_spi.o
#OBJECT	+= feux.o
#OBJECT	+= twi.o

OBJECT	+= kernel.S
OBJECT	+= asm_function.S
OBJECT	+= asm_macro.S
OBJECT	+= memoire.S
OBJECT	+= bidule.S
OBJECT	+= param.S
OBJECT	+= calcul.S
OBJECT	+= wait.S
OBJECT	+= flash.S
OBJECT	+= arguments.S

#OPT	= -Os
PRJSRC	=$(wildcard *.c)
#CMD		= $(shell ssh moi@desktop make -f src/machine/upload.mk)
CMD1	= $(shell scp simple.hex desktop:)
CMD2	= $(shell ssh desktop make -f upload.mk)

#OBJECT	= $(SRC:.c=.o)

#all:	$(OBJECT)
#	$(CC) $(CFLAGS) $(OPT) -o $(PRJ).out -Wl,-Map,$(PRJ).map $(SRC).o
#	$(OBJCOPY) -R .eeprom -O $(HEXFORMAT) $(PRJ).out $(PRJ).hex
#	$(CC) $(CFLAGS) $(OPT) -o $(PRJ).elf $(SRC).o
#	$(OBJDUMP) -h -S $(PRJ).elf > $(PRJ).lst
#CMD	= $(shell ls)


all:	$(OBJECT)
		$(CC) $(CFLAGS) $(OPT) $(OBJECT) -o $(PRJ).out
		#$(STRIP) $(PRJ)
		@printf "\n"
		$(OBJCOPY) -R .eeprom -O $(HEX) $(PRJ).out $(PRJ).hex
		@printf "\n"
		$(OBJDUMP) -h -S $(PRJ).out > $(PRJ).lst

upload:
	echo $(CMD1)
	echo $(CMD2)

stats:
	$(OBJDUMP) -h $(PRJ)
	$(SIZE) $(PRJ) 
		
#upload:
#
#	avrdude -v -c $(TARGET) -P $(PORT) -p $(MCU) -D -U flash:w:$(PRJ).hex:i

install:

	avrdude -vv -c $(TARGET) -P $(PORT) -p $(UP) -U flash:w:$(PRJ).hex:i

rfuses:

	avrdude -vv -c $(TARGET) -P $(PORT) -p $(MCU) \
	-U hfuse:r:-:b -U lfuse:r:-:b -U efuse:r:-:b


wfuses:
	avrdude -vv -c avrispmkII -P $(PORT) -p $(UP) $(FUSES)


erase:
	avrdude -vv -c $(TARGET) -P $(PORT) -p $(MCU) -i 5 -e


clean:
	$(RM) $(PRJ) *.o *.map *.out *.hex *.lst *.elf


