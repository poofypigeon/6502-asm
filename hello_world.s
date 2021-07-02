   org  $8000
START:
    ; clear display
    lda #0b00000001
    sta 0x4000
    sta 0x4004

    ; reset cursor
    lda #0b00000010 
    sta 0x4000
    sta 0x4004

    ; display on
    lda #0b00001110
    sta 0x4000
    sta 0x4004

    ldx #0
WRITE:
    lda DATA, x
    cmp #0
    beq END
    sta 0x4001
    sta 0x4004
    inx
    jmp WRITE

END:
    jmp END

DATA:
    string "Hello world!"
    byte 0

    org $FFFC
    word START
    word $0000
