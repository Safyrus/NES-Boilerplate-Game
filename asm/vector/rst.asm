;***********
; RST vector
;***********

.ifdef C_CODE
.import _main
.endif


RST:
    SEI         ; Disable interrupt
    CLD         ; Clear/disable decimal

    LDX #$FF    ; Initialized stack
    TXS

    INX         ; X=0
    STX PPU_CTRL ; Disable NMI
    STX PPU_MASK ; Disable Rendering
    STX APU_DMC_FREQ ; Disable DMC IRQ

    ; Wait for the PPU to initialized
    BIT PPU_STATUS       ; Clear the VBL flag if it was set at reset time
@vwait1:
    BIT PPU_STATUS
    BPL @vwait1      ; At this point, about 27384 cycles have passed

@clrmem:
    LDA #$00
    STA $0000, x
    STA $0100, x
    STA $0200, x
    STA $0300, x
    STA $0400, x
    STA $0500, x
    STA $0600, x
    STA $0700, x
    INX
    BNE @clrmem

@vwait2:
    BIT PPU_STATUS
    BPL @vwait2      ; At this point, about 57165 cycles have passed

    LDA #%10010000      ; Enable NMI + set background table to $1000
    STA PPU_CTRL
    STA ppu_ctrl_val

    CLI

.ifdef C_CODE
    JMP _main
.else
    JMP MAIN
.endif
