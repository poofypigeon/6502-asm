    org $8000
START
    lda #%00001100 ; display on
    jsr LCD_RDY
    sta $4000
    sta $4004


    ldx #0
LDSTR
    lda DATA, x
    sta $40, x
    inx
    cmp #0
    bne LDSTR


PRINT
    lda #%00000001 ; clear display
    jsr LCD_RDY
    sta $4000
    sta $4004
    lda #%00000010 ; reset cursor
    jsr LCD_RDY
    sta $4000
    sta $4004

    ldx #0
PUTC
    lda $40, x
    cmp #0
    beq ROTATE
    jsr LCD_RDY
    sta $4001
    sta $4004
    inx
    jmp PUTC


ROTATE
    lda $40
    sta $00
    ldx #1
SHIFT
    lda $40, x
    dex
    cmp #0
    beq CYCLE
    sta $40, x
    inx
    inx
    jmp SHIFT
CYCLE
    lda $00
    sta $40, x

    ldx #$80
DLX
    dex
    cpx #0
    beq PRINT
    ldy #$FF
DLY
    dey
    cpy #0
    beq DLX
    jmp DLY
    

LCD_RDY:
    pha
POLL:
    lda $4000
    bmi POLL
    pla
    rts

DATA:
    string "it finally works wow "
    byte 0

    org $FFFC
    word START
    word $0000