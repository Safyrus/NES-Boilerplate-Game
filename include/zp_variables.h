#ifndef _ZP_VARIABLES_
#define _ZP_VARIABLES_

#include "type.h"


// NMI Flags to activate graphical update
// Note: You cannot activate all updates.
//       You need to have a execution time
//       < ~2273 cycles (2000 to be sure)
// 7  bit  0
// ---- ----
// E..R PASB
// |  | ||||
// |  | |||+- Background tiles update
// |  | |||   Execution time depend on data
// |  | |||   (cycles ~= 16 + 38*p + for i:p do (14*p[i].n))
// |  | |||   (p=packet number, p[i].n = packet data size)
// |  | ||+-- Sprites update (513+ cycles)
// |  | |+--- Nametables attributes update (821 cycles)
// |  | +---- Palettes update (356 cycles)
// |  +------ Scroll update (31 cycles)
// +--------- 1 when NMI has ended, should be set to 0 after reading.
//            If let to 1, it means the NMI is disable
extern uint8_t nmi_flags;
#pragma zpsym ("nmi_flags")


// Scroll X position
extern uint8_t scroll_x;
#pragma zpsym ("scroll_x")


// Scroll Y position
extern uint8_t scroll_y;
#pragma zpsym ("scroll_y")


// Nametable high adress to update attributes for
// $23 = Nametable 1
// $27 = Nametable 2
// $2B = Nametable 3
// $2F = Nametable 4
extern uint8_t atr_nametable;
#pragma zpsym ("atr_nametable")


// value of the PPU_MASK (need to be refresh manually)
extern uint8_t ppu_ctrl_val;
#pragma zpsym ("ppu_ctrl_val")


// Attributes data to send to PPU during VBLANK
#define ATTRIBUTES_SIZE 64
extern uint8_t attributes[ATTRIBUTES_SIZE];
#pragma zpsym ("attributes")


// Palettes data to send to PPU during VBLANK
//   byte 0   = transparente color
//   byte 1-3 = background palette 1
//   byte 4-6 = background palette 2
//   ...
//   byte 13-16 = sprite palette 1
//   ...
#define PALETTES_SIZE 25
extern uint8_t palettes[PALETTES_SIZE];
#pragma zpsym ("palettes")


// Background data to send to PPU during VBLANK
// Packet structure:
// byte 0   = v.ssssss (v= vertical draw, s= size)
// byte 1-2 = ppu adress
// byte 3-s = tile data
// packet of size 0 means there is no more data to draw
#define BACKGROUND_SIZE 128
extern uint8_t background[BACKGROUND_SIZE];
#pragma zpsym ("background")

#endif // _ZP_VARIABLES_