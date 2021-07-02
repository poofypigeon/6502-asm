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
    lda data, x
    cmp #0
    beq end
    sta 0x4001
    sta 0x4004
    inx
    jmp WRITE

END:
    jmp end

DATA:
    string "Hello world!"
    byte 0

    org $FFFC
    word start
    word $0000
