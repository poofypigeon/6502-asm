   org  $8000
START:
    ; clear display
    lda #0b00000001 
    jsr LCD_RDY
    sta 0x4000
    sta 0x4004

    ; reset cursor
    lda #0b00000010
    jsr LCD_RDY
    sta 0x4000
    sta 0x4004

    ; display on
    lda #0b00001110
    jsr LCD_RDY
    sta 0x4000
    sta 0x4004

    ldx #0
WRITE:
    lda DATA, x
    cmp #0
    beq END
    jsr LCD_RDY
    sta 0x4001
    sta 0x4004
    inx
    jmp WRITE

END:
    jmp END

LCD_RDY:
    pha
POLL:
    lda 0x4000
    bmi POLL
    pla
    rts

DATA:
    string "Hello world!"
    byte 0

    org $FFFC
    word START
    word $0000
