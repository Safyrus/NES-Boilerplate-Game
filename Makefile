# - - - - - - - - - - - - - #
#    Variables to change    #
# - - - - - - - - - - - - - #

# CC65 executable locations
CC65 = ../../cc65/bin/cc65.exe

# CA65 executable locations
CA65 = ../../cc65/bin/ca65.exe

# LD65 executable locations
LD65 = ../../cc65/bin/ld65.exe

# NES lib locations
NESLIB = ../../cc65/lib/nes.lib

# asminc folder locations
ASMINC = ../../cc65/asminc

# Emulator executable location
EMULATOR = ../../Mesen/Mesen.exe

# Hexdump executable location
HEXDUMP = ..\..\hexdump.exe

# Game name
GAME_NAME = Boilerplate

# Folder with h files to include
INC = include

# Folder with c sources files
SRC = src

# Bin folder for binary output
BIN = bin

# Folder with assembler sources files
ASM = asm

# Change this to 0 if you don't want FamiStudio
FAMISTUDIO = 1

# Change this to 1 if you want the MMC5 mapper
MMC5 = 0


# ! - - - - - - - - - - - - - - - - ! #
#  DO NOT CHANGE ANYTHING AFTER THIS  #
# ! - - - - - - - - - - - - - - - - ! #


# get all c files
SRCFILE    = $(call rwildcard,$(SRC),*.c)

rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))


# make the nes game from assembler files and from c files
all:
	make asm
	make c


# make the nes game from c files
c: $(GAME_NAME)_c.nes
	make clean


# make the nes game from assembler files
asm: $(GAME_NAME)_a.nes
	make clean


# create the nes file from assembler sources
$(GAME_NAME)_a.nes:
# create folder if it does not exist
	@-if not exist "$(BIN)" ( mkdir "$(BIN)" )
# assemble main file
	.\$(CA65) asm/crt0.asm -o $(BIN)/$(GAME_NAME).o --debug-info -DFAMISTUDIO=$(FAMISTUDIO) -DMMC5=$(MMC5)
# link files
ifeq ($(MMC5),1)
	.\$(LD65) $(BIN)/$(GAME_NAME).o -C $(GAME_NAME)_mmc5.cfg -o $(GAME_NAME)_a.nes --dbgfile $(GAME_NAME)_a.DBG
else
	.\$(LD65) $(BIN)/$(GAME_NAME).o -C $(GAME_NAME).cfg -o $(GAME_NAME)_a.nes --dbgfile $(GAME_NAME)_a.DBG
endif


# create the nes file from c sources
$(GAME_NAME)_c.nes: $(addprefix $(BIN)/,$(SRCFILE:.c=.o))
# assemble main file
	$(CA65) $(ASM)/crt0.asm -g -o $(BIN)/$(GAME_NAME).o -I$(ASMINC) -DC_CODE -DFAMISTUDIO=$(FAMISTUDIO) -DMMC5=$(MMC5)
# link files
ifeq ($(MMC5),1)
	$(LD65) $(BIN)/$(GAME_NAME).o $^ -C $(GAME_NAME)_mmc5.cfg -o $@ $(NESLIB) --dbgfile $(GAME_NAME)_c.DBG
else
	$(LD65) $(BIN)/$(GAME_NAME).o $^ -C $(GAME_NAME).cfg -o $@ $(NESLIB) --dbgfile $(GAME_NAME)_c.DBG
endif


# assemble object files
$(BIN)/%.o: $(BIN)/%.asm
# create folder if it does not exist
	@-if not exist "$(@D)" ( mkdir "$(@D)" )
# assemble a file
	$(CA65) -g -I$(INC) -I$(ASMINC) -o $@ $^ -DC_CODE -DFAMISTUDIO=$(FAMISTUDIO) -DMMC5=$(MMC5)


# compile c files
$(BIN)/%.asm: %.c
# create folder if it does not exist
	@-if not exist "$(@D)" ( mkdir "$(@D)" )
# compile a file
	$(CC65) -O -g -I$(INC) -I$(ASM) -o $@ $^ $(NESLIB) --add-source -DFAMISTUDIO=$(FAMISTUDIO) -DMMC5=$(MMC5)


# clean object files
clean:
	@-if exist "$(BIN)" ( rmdir /Q /S "$(BIN)" )


# clean all generated files
clean_all:
	make clean
	del $(GAME_NAME)_a.nes
	del $(GAME_NAME)_a.DBG
	del $(GAME_NAME)_c.nes
	del $(GAME_NAME)_c.DBG
	del dump_$(GAME_NAME)_a.txt
	del dump_$(GAME_NAME)_c.txt


# run the nes game generated with c sources
run_c:
	$(EMULATOR) $(GAME_NAME)_c.nes


# run the nes game generated with assembler sources
run_a:
	$(EMULATOR) $(GAME_NAME)_a.nes


# dump the nes files binary into hexa text
hex:
	$(HEXDUMP) $(GAME_NAME)_a.nes > dump_$(GAME_NAME)_a.txt
	$(HEXDUMP) $(GAME_NAME)_c.nes > dump_$(GAME_NAME)_c.txt