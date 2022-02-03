# **NES Boilerplate Game**

A NES game that serves as a base for starting a new NES project.

-----------------

- [**Features**](##-**Features**)
- [**Prerequisite**](##-**Prerequisite**)
- [**Project configuration**](##-**Project-configuration**)
  - [**Source configuration**](###-**Source-configuration**)
  - [**Makefile configuration**](###-**Makefile-configuration**)
  - [**FamiStudio configuration**](###-**FamiStudio-configuration**)
- [**Building the game**](##--**Building-the-game**)
- [**Running the game**](##--**Running-the-game**)

-----------------

## **Features**

This project has/can:

- Compile the game from assembly code.
- Compile the game from c code.
- A reset handler that reset memory to 0 and call the main function.
- A general NMI handler to draw stuff on the screen.
- An IRQ handler (that does nothing, but we need one).
- Support for the FamiStudio Sound Engine (<https://famistudio.org>)
- Some defined constant (PPU, APU, etc.).

Note: *This project has no mapper. i.e. it is a NROM game with 32K of PRG and 8K of CHR by default.*

-----------------

## **Prerequisite**

### **CC65**

You will need to have CC65 and the files that comes with it.
It can be downloaded here: <https://cc65.github.io>

### **Emulator**

You theoretically don't need a NES emulator,
but unless your developing on hardware without testing on software (why ?),
I recommend the Mesen emulator because of these debugging features: <https://www.mesen.ca>

### **Other (Optional)**

#### **NesDev Wiki**

In case you don't know this website exist, it is **THE most useful** website about how to program on the NES and many other things: <https://wiki.nesdev.org>

#### **Text Editor**

Choose any software you want to write your code, I personally like VS Code because of the syntax highlight and error checking, but use what you are comfortable with.

#### **Hexdump**

You can download "Hexdump for Windows" if you need to output files in hexadecimal: <https://www.di-mgt.com.au/hexdump-for-windows.html>

#### **YY-CHR**

YY-CHR is an editor that you can use to edit the background and sprites in your CHR of your game: <https://w.atwiki.jp/yychr>

#### **FamiStudio**

If you want sound and music in your game, you can use the FamiStudio NES Music Editor: <https://famistudio.org>

It is the most user-friendly music software for the NES that I have found (from a composing and a programming point of view).

-----------------

## **Project configuration**

Before you start making your game, you will need to set some value in the source files and the Makefile.

### **Source configuration**

To configure the sources files, you must:

1. Rename the default .CHR file to `your_game_name.chr`.
2. Replace the value of the first line in the file `asm/constant.asm` to `your_game_name.chr`. Example:

    ```ca65
    .define GAME_CHR "my_game_name.chr"
    ```

3. Rename the .cfg file to `your_game_name.cfg`.
4. *(Optional)* get the FamiStudio Sound Engine
    1. Place the `famistudio_ca65.s` file in `asm/audio/`
    *Note: if you are coding in C, you should include `famistudio_cc65.h` somewhere in your include folder*
    2. in the `crt0.asm` in the FamiStudio section, include your music files. Example:

    ```ca65
    ...
    .if FAMISTUDIO=1
        ...

        ; Musics
        .include "audio/music/my_music.s"

    .endif
    ...
    ```

### **Makefile configuration**

You will need to indicate to the Makefile where cc65 and other software programs are located. All value that you can change is at the top of the file.

- **CC65**: *(Required for C programming)*
    Location of the cc65 compiler executable. Example:

    ```make
    CC65 = cc65/bin/cc65.exe
    ```

- **CA65**: *(Required)*
    Location of the ca65 assembler executable. Example:

    ```make
    CA65 = cc65/bin/ca65.exe
    ```

- **LD65**: *(Required)*
    Location of the ld65 linker executable. Example:

    ```make
    LD65 = cc65/bin/ld65.exe
    ```

- **NESLIB**: *(Required for C programming)*
    Location of the NES library of cc65. Example:

    ```make
    NESLIB = cc65/lib/nes.lib
    ```

- **ASMINC**: *(Required for C programming)*
    Location of the assembly include folder of cc65. Example:

    ```make
    ASMINC = cc65/asminc
    ```

- **EMULATOR**: *(Optional but recommended)*
    Location of the NES emulator. Example:

    ```make
    EMULATOR = Mesen/Mesen.exe
    ```

- **HEXDUMP**: *(Optional)*
    Location of the Hexdump program. Example:

    ```make
    HEXDUMP = hexdump.exe
    ```

- **GAME_NAME**: *(Required)*
    Name of the game. Example:

    ```make
    GAME_NAME = my_game_name
    ```

- **INC**: *(Required for C programming)*
    Include folder where all the header files (.h) are located. Example:

    ```make
    INC = inc
    ```

- **SRC**: *(Required for C programming)*
    Source folder where all the source files (.c) are located. Example:

    ```make
    SRC = src
    ```

- **BIN**: *(Required)*
    Output folder where all the (temporary) binary files will be generated. Example:

    ```make
    BIN = bin
    ```

- **ASM**: *(Required)*
    Assembly folder where all the assembly files are located. Example:

    ```make
    ASM = asm
    ```

- **FAMISTUDIO**: *(Required)*
    Tell the Makefile if you want to include FamiStudio in your game. 1 is for "Yes" and 0 is for "No". Example:

    ```make
    FAMISTUDIO = 1
    ```

### **FamiStudio configuration**

You can configure the engine by editing `asm/audio/famistudio_config.asm`.
If you need help, you can check the FamiStudio documentation: <https://famistudio.org/doc/soundengine>

## **Building the game**

Note: make sure that you have correctly set up the Makefile and source files.

### **From Assembler code**

Your code will need to start in the `MAIN` subroutine.
It is located by default in `asm/main.asm`
You can remove the default code. It is only here to see if the game default features works.

You can build the game with this command:

```console
make -s asm
```

### **from C code**

Your code will need to start in the `main()` function.
It is located by default in `src/main.c`
You can remove the default code. It is only here to see if the game default features works.

You can build the game with this command:

```console
make -s c
```

-----------------

## **Running the game**

You can just run the .NES file with the emulator of your choice.

You can also use this command to run the game made with assembly code:

```console
make -s run_a
```

or this one to run the game made with C code:

```console
make -s run_c
```

## **Other**

### **Cleaning**

You can remove all binary generated files by running:

```console
make -s clean
```

You can remove all the files that have been generated by running:

```console
make -s clean_all
```

### **NES to Hex**

You can convert the NES game into a text file written in hexadecimal:

```console
make -s hex
```
