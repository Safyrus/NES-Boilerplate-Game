#include "constant.h"
#include "zp_variables.h"
#include "ram_variables.h"
#include "famistudio_cc65.h"

// #pragma bss-name(push, "ZEROPAGE")

// test variable in zeropage
// uint8_t zeroPageVar;

// #pragma bss-name(push, "BSS")

// test variable in RAM
// uint8_t ramVar;

extern uint8_t music_data_arpeggio[];

void init()
{
    famistudio_init(1, music_data_arpeggio);
    famistudio_music_play(0);
    // zeroPageVar = 0;
    // ramVar = 0;
}

void loop()
{
    static uint8_t i = 0;

    // set PPU_MASK to draw background and sprites
    *(uint8_t *)PPU_MASK = PPU_MASK_BKG + PPU_MASK_BKG8 + PPU_MASK_SPR + PPU_MASK_SPR8;

    // tell to the nmi what we want to do for the next frame
    nmi_flags = NMI_SCRL + NMI_PLT + NMI_BKG + NMI_ATR + NMI_SPR;

    // tall the nmi we want to change the attruvtes of the first nametable
    atr_nametable = 0x23;

    // reset attributes
    do
    {
        attributes[i] = 0;
        ++i;
    } while (i < ATTRIBUTES_SIZE);

    // reset paletttes
    i = 0;
    do
    {
        palettes[i] = i;
        ++i;
    } while (i < PALETTES_SIZE);

    // update sprite
    OAM[0] = 0x40;
    OAM[1] = 0x01;
    OAM[2] = 0x00;
    OAM[3] = game_state;

    // update background
    background[0] = 0x05;
    background[1] = 0x20;
    background[2] = game_state;
    background[3] = 0x04;
    background[4] = 0x00;
    background[5] = 0x01;
    background[6] = 0x02;
    background[7] = 0x03;
    background[8] = 0x00;

    // inc variables
    // ++zeroPageVar;
    // ++ramVar;
    ++game_state;
}

void main()
{
    init();
    while (1)
    {
        // wait for the next frame
        while ((nmi_flags & 0x80) == 0)
        {
        }
        famistudio_update();

        loop();
    }
}
