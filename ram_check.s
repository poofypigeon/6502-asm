    org 0x8000

MAIN:
; configure LCD display
    lda #0b00000001 
    sta 0x4000
    lda #0b00000010
    sta 0x4000
    lda #0b00001100 
    sta 0x4000

; copy string to memory
    ldx #0
WRITE_MEM:
    lda DATA, x
    sta 0x40, x
    inx
    cmp #0
    beq BRKWM
    jmp WRITE_MEM
BRKWM:

; write string from memory to display
    ldx #0
WRITE_LCD:
    lda 0x40, x
    cmp #0
    beq BRKWL
    sta 0x4001
    inx
    jmp WRITE_LCD
BRKWL:
    jmp BRKWL

DATA:
    string "OwO what's this?"
    byte 0

    org $FFFC
    word MAIN
    word $0000