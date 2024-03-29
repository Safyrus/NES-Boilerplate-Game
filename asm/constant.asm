;**********
; Constants
;**********

; Replace the value with the name of your CHR file
.define GAME_CHR "Boilerplate.chr"



;----------
; PPU
;----------
PPU_CTRL   := $2000
PPU_MASK   := $2001
PPU_STATUS := $2002
PPU_SCROLL := $2005
PPU_ADDR   := $2006
PPU_DATA   := $2007

; PPU MASK
PPU_MASK_GREY = %00000001
PPU_MASK_BKG8 = %00000010
PPU_MASK_SPR8 = %00000100
PPU_MASK_BKG  = %00001000
PPU_MASK_SPR  = %00010000
PPU_MASK_R    = %00100000
PPU_MASK_G    = %01000000
PPU_MASK_B    = %10000000

; PPU CTRL
PPU_CTRL_NM_1     = %00000001
PPU_CTRL_NM_2     = %00000010
PPU_CTRL_INC      = %00000100
PPU_CTRL_SPR      = %00001000
PPU_CTRL_BKG      = %00010000
PPU_CTRL_SPR_SIZE = %00100000
PPU_CTRL_SEL      = %01000000
PPU_CTRL_NMI      = %10000000



;----------
; APU
;----------
APU := $4000

APU_SQ1_VOL   := $4000
APU_SQ1_SWEEP := $4001
APU_SQ1_LO    := $4002
APU_SQ1_HI    := $4003

APU_SQ2_VOL   := $4004
APU_SQ2_SWEEP := $4005
APU_SQ2_LO    := $4006
APU_SQ2_HI    := $4007

APU_TRI_LINEAR := $4008
APU_TRI_LO     := $400A
APU_TRI_HI     := $400B

APU_NOISE_VOL := $400C
APU_NOISE_LO  := $400E
APU_NOISE_HI  := $400F

APU_DMC_FREQ  := $4010
APU_DMC_RAW   := $4011
APU_DMC_START := $4012
APU_DMC_LEN   := $4013

APU_SND_CHN := $4015
APU_CTRL    := $4015
APU_STATUS  := $4015
APU_FRAME   := $4017



;----------
; OAM
;----------
OAMDMA := $4014



;----------
; IO
;----------
IO_JOY1 := $4016
IO_JOY2 := $4017


;----------
; NMI
;----------
NMI_DONE = %10000000
NMI_SCRL = %00010000
NMI_PLT  = %00001000
NMI_ATR  = %00000100
NMI_SPR  = %00000010
NMI_BKG  = %00000001


;----------
; MMC5
;----------
.ifdef MMC5
MMC5_PRG_MODE := $5100
MMC5_CHR_MODE := $5101
MMC5_RAM_BNK  := $5113
MMC5_PRG_BNK0 := $5114
MMC5_PRG_BNK1 := $5115
MMC5_PRG_BNK2 := $5116
MMC5_PRG_BNK3 := $5117
.endif