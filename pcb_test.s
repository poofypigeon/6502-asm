    .org $8000
MAIN:
    lda #%00000001
    sta $40

LOOP:
    clc
    lda $40
    sta $4000

    cmp #%10000000
    beq RESET
    rol $40
    jmp DELAY
RESET:
    lda #%00000001
    sta $40

DELAY:
    ldx #$80
DLX:
    dex
    cpx #0
    beq LOOP
    ldy #$FF
DLY:
    dey
    cpy #0
    beq DLX
    jmp DLY

    .org $FFFC
    .word MAIN
    .word $0000