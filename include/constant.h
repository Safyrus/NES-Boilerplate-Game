#ifndef _CONSTANT_H_
#define _CONSTANT_H_

#include "type.h"

// ----------
//  PPU
// ----------
#define PPU_CTRL 0x2000
#define PPU_MASK 0x2001
#define PPU_STATUS 0x2002
#define PPU_SCROLL 0x2005
#define PPU_ADDR 0x2006
#define PPU_DATA 0x2007

//  PPU MASK
#define PPU_MASK_GREY 0b00000001
#define PPU_MASK_BKG8 0b00000010
#define PPU_MASK_SPR8 0b00000100
#define PPU_MASK_BKG 0b00001000
#define PPU_MASK_SPR 0b00010000
#define PPU_MASK_R 0b00100000
#define PPU_MASK_G 0b01000000
#define PPU_MASK_B 0b10000000

//  PPU CTRL
#define PPU_CTRL_NM_1 0b00000001
#define PPU_CTRL_NM_2 0b00000010
#define PPU_CTRL_INC 0b00000100
#define PPU_CTRL_SPR 0b00001000
#define PPU_CTRL_BKG 0b00010000
#define PPU_CTRL_SPR_SIZE 0b00100000
#define PPU_CTRL_SEL 0b01000000
#define PPU_CTRL_NMI 0b10000000

// ----------
//  APU
// ----------
#define APU 0x4000

#define APU_SQ1_VOL 0x4000
#define APU_SQ1_SWEEP 0x4001
#define APU_SQ1_LO 0x4002
#define APU_SQ1_HI 0x4003

#define APU_SQ2_VOL 0x4004
#define APU_SQ2_SWEEP 0x4005
#define APU_SQ2_LO 0x4006
#define APU_SQ2_HI 0x4007

#define APU_TRI_LINEAR 0x4008
#define APU_TRI_LO 0x400A
#define APU_TRI_HI 0x400B

#define APU_NOISE_VOL 0x400C
#define APU_NOISE_LO 0x400E
#define APU_NOISE_HI 0x400F

#define APU_DMC_FREQ 0x4010
#define APU_DMC_RAW 0x4011
#define APU_DMC_START 0x4012
#define APU_DMC_LEN 0x4013

#define APU_SND_CHN 0x4015
#define APU_CTRL 0x4015
#define APU_STATUS 0x4015
#define APU_FRAME 0x4017

// ----------
//  OAM
// ----------
#define OAMDMA 0x4014

// ----------
//  IO
// ----------
#define IO_JOY1 0x4016
#define IO_JOY2 0x4017

// ----------
//  NMI
// ----------
#define NMI_DONE 0b10000000
#define NMI_SCRL 0b00010000
#define NMI_PLT 0b00001000
#define NMI_ATR 0b00000100
#define NMI_SPR 0b00000010
#define NMI_BKG 0b00000001

#endif // _CONSTANT_H_