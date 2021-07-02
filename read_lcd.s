   org  $8000
MAIN:
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
    beq BRK
    sta 0x4001
    sta 0x4004
    inx
    jmp WRITE
BRK:

; move lcd cursor to prev char
    lda #0b10000010
    sta 0x4000
    sta 0x4004

; get char from lcd and store in mem
    lda 0x4003
    sta 0x40
    
; move lcd curser to free space
    lda #0b10000100
    sta 0x4000
    sta 0x4004

; print stored character to display
    lda 0x40
    sta 0x4001
    sta 0x4004

END:
    jmp END

DATA:
    string "ABC"
    byte 0

    org $FFFC
    word MAIN
    word $0000