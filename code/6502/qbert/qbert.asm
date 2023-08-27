

; Troy's HBC-56 - Breakout
;
; Copyright (c) 2022 Troy Schrapel
;
; This code is licensed under the MIT license
;
; https://github.com/visrealm/hbc-56
;

!src "hbc56kernel.inc"

!src "io/timer.inc"


; Zero page addresses
; -------------------------
ZP0 = HBC56_USER_ZP_START

QBERT_STATE   = ZP0
QBERT_DIR     = ZP0 + 1
QBERT_ANIM    = ZP0 + 2
QBERT_X       = ZP0 + 3
QBERT_Y       = ZP0 + 4
SCORE_L       = ZP0 + 5
SCORE_M       = ZP0 + 6
SCORE_H       = ZP0 + 7
TMP           = ZP0 + 8
TMP2          = ZP0 + 9
CELL_X        = ZP0 + 10
CELL_Y        = ZP0 + 11

TONE0                   = ZP0 + 12
TONE1                   = ZP0 + 13
TONE0_                  = ZP0 + 14
TONE1_                  = ZP0 + 25


; actors
;   - id
;   - typeid
;   - state
;   - facing
;   - 


; cells
;   - x
;   - y
;   - color

; setBlockColors (c1, c2, c3, left, right)


!src "audio.asm"


; -----------------------------------------------------------------------------
; HBC-56 Program Metadata
; -----------------------------------------------------------------------------
hbc56Meta:
        +setHbcMetaTitle "Q*BERT-56"
        +setHbcMetaNES
        rts

; -----------------------------------------------------------------------------
; HBC-56 Program Entry
; -----------------------------------------------------------------------------
hbc56Main:
        sei

        ; go to graphics II mode
        jsr tmsModeGraphicsII

        ; disable display durint init
        +tmsDisableInterrupts
        +tmsDisableOutput

        lda #TMS_R1_SPRITE_MAG2
        jsr tmsReg1ClearFields
        lda #TMS_R1_SPRITE_16
        jsr tmsReg1SetFields

        ; set backrground
        +tmsSetColorFgBg TMS_WHITE, TMS_BLACK


        jsr clearVram
        jsr tilesToVram

        +tmsSetPosWrite 0, 0
        +tmsSendData .gameTable, 32*24

        +tmsEnableOutput

        +hbc56SetVsyncCallback gameLoop
        +tmsEnableInterrupts

        lda #0
        sta QBERT_STATE
        sta QBERT_DIR
        sta QBERT_ANIM
        sta SCORE_L
        sta SCORE_M
        sta SCORE_H

        jsr resetBert

        jsr .bertSpriteRestDR

        jsr audioInit

        +hbc56SetViaCallback timerHandler

        cli

        jmp hbc56Stop

timerHandler:
        bit VIA_IO_ADDR_T1C_L
        jsr audioJumpTick
        lda PCM_PLAYING
        bne +
        +timer1Stop
+
        rts

resetBert:
        lda #120
        sta QBERT_X
        lda #12
        sta QBERT_Y

        lda #14
        sta CELL_X
        lda #2
        sta CELL_Y
        rts

.bertSpriteRestDR:

        lda QBERT_Y
        cmp #170
        bcc +
        jsr resetBert
+

        +tmsCreateSprite 0, 0, 120, 8, TMS_DK_RED
        +tmsCreateSprite 1, 4, 120, 13, TMS_BLACK
        +tmsCreateSprite 2, 8, 120, -3, TMS_WHITE
        jmp .updateBertSpriteRest

.bertSpriteJumpDR
        +tmsCreateSprite 0, 12, 120, 7, TMS_DK_RED
        +tmsCreateSprite 1, 16, 120, 10, TMS_BLACK
        +tmsCreateSprite 2, 20, 120, -6, TMS_WHITE
        jmp .updateBertSpriteJump

.bertSpriteRestDL:
        lda QBERT_Y
        cmp #170
        bcc +
        jsr resetBert
+

        +tmsCreateSprite 0, 24, 120, 8, TMS_DK_RED
        +tmsCreateSprite 1, 28, 120, 13, TMS_BLACK
        +tmsCreateSprite 2, 32, 120, -3, TMS_WHITE
        jmp .updateBertSpriteRest

.bertSpriteJumpDL
        +tmsCreateSprite 0, 36, 120, 7, TMS_DK_RED
        +tmsCreateSprite 1, 40, 120, 10, TMS_BLACK
        +tmsCreateSprite 2, 44, 120, -6, TMS_WHITE
        jmp .updateBertSpriteJump



.bertSpriteRestUR:
        +tmsCreateSprite 0, 48+0, 120, 8, TMS_DK_RED
        +tmsCreateSprite 1, 48+4, 120, 13, TMS_BLACK
        +tmsCreateSprite 2, 48+8, 120, -3, TMS_WHITE
        jmp .updateBertSpriteRest

.bertSpriteJumpUR
        +tmsCreateSprite 0, 48+12, 120, 7, TMS_DK_RED
        +tmsCreateSprite 1, 48+16, 120, 10, TMS_BLACK
        +tmsCreateSprite 2, 48+20, 120, -6, TMS_WHITE
        jmp .updateBertSpriteJump


.bertSpriteRestUL:
        +tmsCreateSprite 0, 48+24, 120, 8, TMS_DK_RED
        +tmsCreateSprite 1, 48+28, 120, 13, TMS_BLACK
        +tmsCreateSprite 2, 48+32, 120, -3, TMS_WHITE
        jmp .updateBertSpriteRest

.bertSpriteJumpUL
        +tmsCreateSprite 0, 48+36, 120, 7, TMS_DK_RED
        +tmsCreateSprite 1, 48+40, 120, 10, TMS_BLACK
        +tmsCreateSprite 2, 48+44, 120, -6, TMS_WHITE
        jmp .updateBertSpriteJump



.updateBertSpriteRest
        ldx QBERT_X
        ldy QBERT_Y
        +tmsSpritePosXYReg 1
        dey
        dey
        dey
        dey
        dey
        +tmsSpritePosXYReg 0
        lda QBERT_DIR
        bit #2
        clc
        beq +
        sec
+
        tya
        adc #-11
        tay
        +tmsSpritePosXYReg 2
        rts

.updateBertSpriteJump
        ldx QBERT_X
        ldy QBERT_Y
        +tmsSpritePosXYReg 1
        dey
        dey
        dey
        +tmsSpritePosXYReg 0
        lda QBERT_DIR
        bit #2
        clc
        beq +
        sec
+
        tya
        adc #-13
        tay
        +tmsSpritePosXYReg 2
        rts



.updatePos:
        +tmsSetColorFgBg TMS_WHITE, TMS_DK_GREEN

        lda QBERT_ANIM
        beq .endAnim
        lda QBERT_ANIM
        dec
        tax

        lda QBERT_DIR
        bit #1
        bne +
        lda QBERT_X
        clc
        adc .bertJumpAnimX,X
        sta QBERT_X
        bra @endX
+
        lda QBERT_X
        sec
        sbc .bertJumpAnimX,X
        sta QBERT_X
@endX
        lda QBERT_DIR
        bit #2
        bne +

        lda QBERT_Y
        clc
        adc .bertJumpAnimY,X
        sta QBERT_Y
        bra @endY
+
        stx TMP
        lda #31
        sec
        sbc TMP
        tax
        lda QBERT_Y
        sec
        sbc .bertJumpAnimY,X
        sta QBERT_Y
@endY:

        jsr .updateBertSpriteJump
.endAnim

        inc QBERT_ANIM
        lda QBERT_ANIM
        cmp #33
        bne @endUpdate

        jsr audioJumpInit
        +timer1SetContinuousHz 4096

        +tmsSetColorFgBg TMS_WHITE, TMS_DK_BLUE

        stz QBERT_STATE
        stz QBERT_ANIM
        lda #$00
        sta TMP
        lda #$25
        jsr scoreAdd
        lda QBERT_DIR
        bne +
        jsr .bertSpriteRestDR
        bra @endSetRestSprite
+
        cmp #1
        bne +
        jsr .bertSpriteRestDL
        bra @endSetRestSprite
+
        cmp #2
        bne +
        jsr .bertSpriteRestUR
        bra @endSetRestSprite
+
        jsr .bertSpriteRestUL

@endSetRestSprite

        bra .updateCell

@endUpdate
        rts

.updateCell:
        lda #8
        sta TMP2
        ldx CELL_X
        ldy CELL_Y
        jsr tmsSetPosRead
        +tmsGet
        bmi +
        rts
+
        pha
        cmp #128+16
        bcc +
        lda #-8
        sta TMP2

+
        +tmsGet
        +tmsGet
        sta TMP
        jsr tmsSetAddressWrite
        pla
        clc
        adc TMP2
        +tmsPut
        inc
        +tmsPut
        
        clc
        lda TMP
        adc TMP2
        +tmsPut
        inc
        +tmsPut


        ldx CELL_X
        ldy CELL_Y
        iny
        jsr tmsSetPosRead
        +tmsGet
        pha
        +tmsGet
        +tmsGet
        sta TMP
        jsr tmsSetAddressWrite

        pla
        clc
        adc TMP2
        +tmsPut
        inc
        +tmsPut
        
        clc
        lda TMP
        adc TMP2
        +tmsPut
        inc
        +tmsPut

@endUpdateCell:
        rts

.bertJumpStart:
        lda #1
        sta QBERT_STATE
        rts

.moveDR:
        lda #0
        sta QBERT_DIR
        jsr .bertJumpStart
        jsr .bertSpriteJumpDR
        inc CELL_Y
        inc CELL_Y
        inc CELL_Y
        inc CELL_X
        inc CELL_X
        jmp .afterControl

.moveDL:
        lda #1
        sta QBERT_DIR
        jsr .bertJumpStart
        jsr .bertSpriteJumpDL
        inc CELL_Y
        inc CELL_Y
        inc CELL_Y
        dec CELL_X
        dec CELL_X
        jmp .afterControl

.moveUR:
        lda #2
        sta QBERT_DIR
        jsr .bertJumpStart
        jsr .bertSpriteJumpUR
        dec CELL_Y
        dec CELL_Y
        dec CELL_Y
        inc CELL_X
        inc CELL_X        
        jmp .afterControl

.moveUL:
        lda #3
        sta QBERT_DIR
        jsr .bertJumpStart
        jsr .bertSpriteJumpUL
        dec CELL_Y
        dec CELL_Y
        dec CELL_Y
        dec CELL_X
        dec CELL_X        
        jmp .afterControl


gameLoop:
        +tmsSetColorFgBg TMS_WHITE, TMS_DK_YELLOW

        lda QBERT_STATE
        beq +
        jsr .updatePos
        bra .afterControl
+
        ; test NES controller
        lda NES1_IO_ADDR
        bit #NES_RIGHT
        beq .moveDR
        bit #NES_DOWN
        beq .moveDL
        bit #NES_LEFT
        beq .moveUL
        bit #NES_UP
        beq .moveUR

.afterControl

        jsr .updateChangeArrows
        jsr .updatePlatformColors

        +tmsSetColorFgBg TMS_WHITE, TMS_BLACK

        rts

.updatePlatformColors:
        lda HBC56_TICKS
        cmp #1
        bne +
        jsr .setPlatformColorBank0
        jsr .updatePlatformColor1
        rts
+
        cmp #2
        bne +
        jsr .setPlatformColorBank1
        jsr .updatePlatformColor1
        rts
+
        cmp #3
        bne +
        jsr .setPlatformColorBank2
        jsr .updatePlatformColor1
        rts
+
        cmp #16
        bne +
        jsr .setPlatformColorBank0
        jsr .updatePlatformColor2
        rts
+
        cmp #17
        bne +
        jsr .setPlatformColorBank1
        jsr .updatePlatformColor2
        rts
+
        cmp #18
        bne +
        jsr .setPlatformColorBank2
        jsr .updatePlatformColor2
        rts
+
        cmp #31
        bne +
        jsr .setPlatformColorBank0
        jsr .updatePlatformColor3
        rts
+
        cmp #32
        bne +
        jsr .setPlatformColorBank1
        jsr .updatePlatformColor3
        rts
+
        cmp #33
        bne +
        jsr .setPlatformColorBank2
        jsr .updatePlatformColor3
        rts
+
        cmp #46
        bne +
        jsr .setPlatformColorBank0
        jsr .updatePlatformColor4
        rts
+
        cmp #47
        bne +
        jsr .setPlatformColorBank1
        jsr .updatePlatformColor4
        rts
+
        cmp #48
        bne +
        jsr .setPlatformColorBank2
        jsr .updatePlatformColor4
+
        rts


.updateChangeArrows:
        lda HBC56_TICKS
        beq @changeArrowsNone
        cmp #20
        beq @changeArrowsOne
        cmp #40
        beq @changeArrowsTwo
        rts

@changeArrowsNone
        jsr .arrowsPosOne
        lda #0
        +tmsPut
        +tmsPut
        jsr .arrowsPosTwo
        lda #0
        +tmsPut
        +tmsPut
        rts
@changeArrowsOne
        jsr .arrowsPosOne
        +tmsPut $c6
        +tmsPut 0
        jsr .arrowsPosTwo
        +tmsPut 0
        +tmsPut $c7
        rts
@changeArrowsTwo
        jsr .arrowsPosOne
        lda #$c6
        +tmsPut
        +tmsPut
        jsr .arrowsPosTwo
        lda #$c7
        +tmsPut
        +tmsPut
        rts
        
.arrowsPosOne
        +tmsSetPosWrite 1, 5
        rts

.arrowsPosTwo
        +tmsSetPosWrite 5, 5
        rts

; -----------------------------------------------------------------------------
; Output two BCD digits to current location
; Inputs:
;   A = BCD encoded value
; -----------------------------------------------------------------------------
outputBCD:
        sta TMP
        +lsr4
        ora #'0'
        +tmsPut
        lda TMP
outputBCDLow:
        and #$0f
        ora #'0'
        +tmsPut
        rts


; lsb bcd score to add in accumulator, msb score in TMP
scoreAdd:
        clc
        sed
        adc SCORE_L
        sta SCORE_L
        lda TMP
        adc SCORE_M
        sta SCORE_M
        bcc +
        lda #0
        adc SCORE_H
        sta SCORE_H
+
        cld
        +tmsSetPosWrite 1, 1
        lda SCORE_H
        jsr outputBCD
        lda SCORE_M
        jsr outputBCD
        lda SCORE_L
        jsr outputBCD
        rts


.setPlatformColorBank0
        +tmsSetAddrColorTableIIBank0 1
        rts

.setPlatformColorBank1
        +tmsSetAddrColorTableIIBank1 1
        rts

.setPlatformColorBank2
        +tmsSetAddrColorTableIIBank2 1
        rts

.updatePlatformColor1:
        +tmsSendData .platformPal1, 8 * 4
        rts

.updatePlatformColor2:
        +tmsSendData .platformPal2, 8 * 4
        rts

.updatePlatformColor3:
        +tmsSendData .platformPal3, 8 * 4
        rts

.updatePlatformColor4:
        +tmsSendData .platformPal4, 8 * 4
        rts


; -----------------------------------------------------------------------------
; Clear/reset VRAM
; -----------------------------------------------------------------------------
clearVram:
        ; clear the name table
        +tmsSetAddrNameTable
        lda #0
        jsr _tmsSendPage        
        jsr _tmsSendPage
        jsr _tmsSendPage

        ; set all color table entries to transparent
        +tmsSetAddrColorTable
        +tmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
        jsr _tmsSendKb
        jsr _tmsSendKb
        jsr _tmsSendKb
        jsr _tmsSendKb
        jsr _tmsSendKb
        jsr _tmsSendKb        

        ; clear the pattern table
        +tmsSetAddrPattTable
        lda #0
        jsr _tmsSendKb
        jsr _tmsSendKb
        jsr _tmsSendKb
        jsr _tmsSendKb
        jsr _tmsSendKb
        jsr _tmsSendKb
        rts

tilesToVram:

        ; brick patterns (for each bank)
        +tmsSetAddrPattTableIIBank0 1
        +tmsSendData .platformPatt, 8 * 4
        +tmsSendData .bertCharPatt, 8 * 4

        +tmsSetAddrPattTableIIBank1 1
        +tmsSendData .platformPatt, 8 * 4
        +tmsSendData .bertCharPatt, 8 * 4

        +tmsSetAddrPattTableIIBank2 1
        +tmsSendData .platformPatt, 8 * 4
        +tmsSendData .bertCharPatt, 8 * 4


        ; brick colors (for each bank)
        +tmsSetAddrColorTableIIBank0 1
        +tmsSendData .platformPal2, 8 * 4
        +tmsSendData .bertCharColor, 8 * 4

        +tmsSetAddrColorTableIIBank1 1
        +tmsSendData .platformPal2, 8 * 4
        +tmsSendData .bertCharColor, 8 * 4

        +tmsSetAddrColorTableIIBank2 1
        +tmsSendData .platformPal2, 8 * 4        
        +tmsSendData .bertCharColor, 8 * 4

        +tmsSetAddrPattTableIIBank0 128
        jsr .buildTopBlocks
        +tmsSetAddrPattTableIIBank0 160
        jsr .buildBottomBlocks

        +tmsSetAddrColorTableIIBank0 128
        jsr .buildTopBlocksColor
        +tmsSetAddrColorTableIIBank0 160
        jsr .buildBottomBlocksColor

        +tmsSetAddrPattTableIIBank0 254
        +tmsSendData .clearPatt, 8 * 2
        +tmsSetAddrColorTableIIBank0 254
        +tmsPutRpt $fe, 8 * 2

        +tmsSetAddrPattTableIIBank1 128
        jsr .buildTopBlocks
        +tmsSetAddrPattTableIIBank1 160
        jsr .buildBottomBlocks

        +tmsSetAddrColorTableIIBank1 128
        jsr .buildTopBlocksColor
        +tmsSetAddrColorTableIIBank1 160
        jsr .buildBottomBlocksColor

        +tmsSetAddrPattTableIIBank1 254
        +tmsSendData .clearPatt, 8 * 2
        +tmsSetAddrColorTableIIBank1 254
        +tmsPutRpt $fe, 8 * 2

        +tmsSetAddrPattTableIIBank2 128
        jsr .buildTopBlocks
        +tmsSetAddrPattTableIIBank2 160
        jsr .buildBottomBlocks

        +tmsSetAddrColorTableIIBank2 128
        jsr .buildTopBlocksColor
        +tmsSetAddrColorTableIIBank2 160
        jsr .buildBottomBlocksColor

        +tmsSetAddrPattTableIIBank2 254
        +tmsSendData .clearPatt, 8 * 2
        +tmsSetAddrColorTableIIBank2 254
        +tmsPutRpt $fe, 8 * 2


        +tmsSetAddrSpritePattTable
        +tmsSendData .bertPattR, 8 * 4 * 3 * 2 * 4

        +tmsSetAddrPattTableIIBank0 192
        +tmsSendData .changeToPatt, 8 * 8
        +tmsSetAddrColorTableIIBank0 192
        +tmsPutRpt $80, 8 * 6
        +tmsPutRpt $d0, 8 * 2


        ; text
        +tmsSetAddrPattTableIIBank0 ' '
        +tmsSendData TMS_FONT_DATA, 8 * 64

        +tmsSetAddrColorTableIIBank0 ' '
        +tmsSendDataRpt .fontPal, 8, 64

        +tmsSetAddrColorTableIIBank0 '0'
        +tmsSendDataRpt .digitsPal, 8, 10

        rts        

.buildTopBlocks:
        +tmsSendData .blockPatt, 8 * 4
        +tmsSendData .blockPatt, 8 * 4
        +tmsSendData .blockPatt, 8 * 4
        +tmsSendData .blockPatt, 8 * 4
        +tmsSendData .blockPatt, 8 * 4
        +tmsSendData .blockPatt, 8 * 4
        +tmsSendData .blockPatt, 8 * 4
        +tmsSendData .blockPatt, 8 * 4
        rts

.buildBottomBlocks:
        +tmsSendData .blockPatt2, 8 * 4
        +tmsSendData .blockPatt2, 8 * 4
        +tmsSendData .blockPatt2, 8 * 4
        +tmsSendData .blockPatt2, 8 * 4
        +tmsSendData .blockPatt2, 8 * 4
        +tmsSendData .blockPatt2, 8 * 4
        +tmsSendData .blockPatt2, 8 * 4
        +tmsSendData .blockPatt2, 8 * 4
        rts

.buildTopBlocksColor:
        +tmsPutRpt $50, 8 * 4
        +tmsPutRpt $5e, 8 * 2
        +tmsPutRpt $5f, 8 * 2
        +tmsPutRpt $b0, 8 * 4
        +tmsPutRpt $be, 8 * 2
        +tmsPutRpt $bf, 8 * 2
        +tmsPutRpt $20, 8 * 4
        +tmsPutRpt $2e, 8 * 2
        +tmsPutRpt $2f, 8 * 2
        rts

.buildBottomBlocksColor:
        +tmsPutRpt $f0, 8 * 2
        +tmsPutRpt $e0, 8 * 2
        +tmsPutRpt $5f, 8 * 2
        +tmsPutRpt $5e, 8 * 2
        +tmsPutRpt $f0, 8 * 2
        +tmsPutRpt $e0, 8 * 2
        +tmsPutRpt $bf, 8 * 2
        +tmsPutRpt $be, 8 * 2
        +tmsPutRpt $f0, 8 * 2
        +tmsPutRpt $e0, 8 * 2
        +tmsPutRpt $2f, 8 * 2
        +tmsPutRpt $2e, 8 * 2
        rts

.fontPal
+byteTmsColorFgBg TMS_DK_BLUE, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_LT_BLUE, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_CYAN, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_WHITE, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_CYAN, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_LT_BLUE, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_DK_BLUE, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_DK_BLUE, TMS_TRANSPARENT

.digitsPal
+byteTmsColorFgBg TMS_DK_GREEN, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_MED_GREEN, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_LT_GREEN, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_WHITE, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_LT_GREEN, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_MED_GREEN, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_DK_GREEN, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_DK_GREEN, TMS_TRANSPARENT



.bertCharPatt:
!byte $00,$00,$3e,$7f,$e4,$e4,$ff,$ff
!byte $3e,$7f,$3f,$22,$22,$22,$33,$19
!byte $00,$00,$00,$00,$00,$00,$c0,$e0
!byte $f0,$c8,$48,$30,$00,$00,$00,$80

.bertCharColor:
!byte $80,$80,$90,$90,$8f,$81,$80,$80
!byte $86,$60,$60,$60,$60,$60,$80,$80
!byte $80,$80,$80,$80,$80,$80,$90,$90
!byte $80,$80,$80,$60,$60,$60,$80,$80


.blockPatt:
!byte $00,$00,$00,$00,$01,$07,$1F,$7F
!byte $01,$07,$1F,$7F,$FF,$FF,$FF,$FF
!byte $80,$E0,$F8,$FE,$FF,$FF,$FF,$FF
!byte $00,$00,$00,$00,$80,$E0,$F8,$FE

.blockPatt2:
!byte $7F,$1F,$07,$01,$00,$00,$00,$00   
!byte $FF,$FF,$FF,$FF,$7F,$1F,$07,$01   
!byte $FF,$FF,$FF,$FF,$FE,$F8,$E0,$80
!byte $FE,$F8,$E0,$80,$00,$00,$00,$00


.clearPatt:
!byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
!byte $00,$00,$00,$00,$00,$00,$00,$00

.bertPattR:             ; squatted
!byte $00,$00,$0f,$3f,$79,$f9,$ff,$ff  ; red
!byte $ff,$ff,$7f,$3f,$1f,$09,$39,$1e
!byte $00,$00,$00,$c0,$00,$00,$e0,$f8
!byte $fc,$fe,$b2,$12,$0c,$00,$c0,$70

!byte $06,$00,$00,$00,$00,$00,$00,$00 ; black offset y+5
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $c0,$00,$00,$00,$00,$0c,$0c,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00

!byte $00,$00,$00,$00,$00,$00,$00,$00  ; white offset y-13
!byte $00,$00,$00,$00,$00,$00,$00,$06
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$c0

                        ; jump
!byte $0f,$3f,$79,$79,$f9,$ff,$ff,$ff   ; red
!byte $7f,$3f,$1f,$11,$11,$11,$39,$1e
!byte $00,$c0,$00,$00,$20,$f8,$fc,$fe
!byte $b2,$12,$0c,$00,$00,$00,$c0,$70

!byte $06,$06,$00,$00,$00,$00,$00,$00   ; black offset y+3
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $C0,$C0,$00,$00,$00,$0C,$0C,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00

!byte $00,$00,$00,$00,$00,$00,$00,$00   ; white offset y-13
!byte $00,$00,$00,$00,$00,$00,$00,$06
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$C0

.bertPattL:             ; squatted
!byte $00,$00,$00,$03,$00,$00,$07,$1f  ; red
!byte $3f,$7f,$4d,$48,$30,$00,$03,$0e
!byte $00,$00,$f0,$fc,$9e,$9f,$ff,$ff
!byte $ff,$ff,$fe,$fc,$f8,$90,$9c,$78

!byte $03,$00,$00,$00,$00,$30,$30,$00  ; black offset y+5
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $60,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00

!byte $00,$00,$00,$00,$00,$00,$00,$00  ; white offset y-13
!byte $00,$00,$00,$00,$00,$00,$00,$03
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$60

                        ; jump
!byte $00,$03,$00,$00,$04,$1f,$3f,$7f   ; red
!byte $4d,$48,$30,$00,$00,$00,$03,$0e
!byte $f0,$fc,$9e,$9e,$9f,$ff,$ff,$ff
!byte $fe,$fc,$f8,$88,$88,$88,$9c,$78

!byte $03,$03,$00,$00,$00,$30,$30,$00  ; black offset y+3
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $60,$60,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00

!byte $00,$00,$00,$00,$00,$00,$00,$00  ; white offset y-13
!byte $00,$00,$00,$00,$00,$00,$00,$03
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$60


.bertPattUR:           ; squatted
!byte $00,$00,$0f,$1f,$3f,$3f,$7f,$7f   ; red
!byte $7f,$7f,$3f,$1f,$0f,$06,$0f,$1c
!byte $00,$00,$0e,$df,$3f,$3e,$3c,$f8
!byte $f0,$f0,$f0,$e0,$c0,$e0,$d8,$e0

!byte $00,$00,$00,$00,$00,$00,$00,$00  ; black offset y+5
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $40,$40,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00

!byte $00,$00,$00,$00,$00,$00,$00,$00  ; white offset y-12
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$c0,$c0,$80

                        ; jump
!byte $0f,$1f,$3f,$3f,$7f,$7f,$7f,$7f   ; red
!byte $3f,$1f,$0f,$04,$04,$07,$0e,$18
!byte $0e,$df,$3f,$3e,$3c,$f8,$f0,$f0
!byte $f0,$e0,$c0,$80,$c0,$98,$f0,$c0

!byte $00,$00,$00,$00,$00,$00,$00,$00  ; black offset y+3
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $40,$40,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00

!byte $00,$00,$00,$00,$00,$00,$00,$00  ; white offset y-13
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$c0,$c0,$80


.bertPattUL:           ; squatted
!byte $00,$00,$70,$fb,$fc,$7c,$3c,$1f   ; red
!byte $0f,$0f,$0f,$07,$03,$07,$1b,$07
!byte $00,$00,$f0,$f8,$fc,$fc,$fe,$fe
!byte $fe,$fe,$fc,$f8,$f0,$60,$f0,$38

!byte $02,$02,$00,$00,$00,$00,$00,$00  ; black offset y+5
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00

!byte $00,$00,$00,$00,$00,$00,$00,$00  ; white offset y-12
!byte $00,$00,$00,$00,$00,$03,$03,$01
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00

                        ; jump
!byte $70,$fb,$fc,$7c,$3c,$1f,$0f,$0f  ; red
!byte $0f,$07,$03,$01,$03,$19,$0f,$03
!byte $f0,$f8,$fc,$fc,$fe,$fe,$fe,$fe
!byte $fc,$f8,$f0,$20,$20,$e0,$70,$18

!byte $02,$02,$00,$00,$00,$00,$00,$00  ; black offset y+3
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00

!byte $00,$00,$00,$00,$00,$00,$00,$00  ; white offset y-13
!byte $00,$00,$00,$00,$00,$03,$03,$01
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00


.bertJumpAnimX
!byte 0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,1,1,1,0,0,0,0
.bertJumpAnimY
!byte -2,-1,-2,-1,-1,-1,0,-1,0,0,0,1,0,1,1,1,2,1,2,1,2,1,2,2,2,2,2,2,2,2,2,2


;.bertJumpAnimX
;!byte 0,0,1,1,2,2,2,2,2,1,1,1,1,0,0,0,0,0
;.bertJumpAnimY
;!byte -3,-2,-2,-1,0,1,2,3,3,3,3,3,3,3,4,4


.changeToPatt
!byte $00,$00,$f4,$84,$87,$84,$f4,$00
!byte $00,$00,$99,$a5,$bd,$a5,$a5,$00
!byte $00,$00,$27,$a8,$6b,$29,$26,$00
!byte $00,$00,$78,$40,$70,$40,$78,$00
!byte $00,$00,$3e,$08,$08,$08,$08,$00
!byte $00,$00,$60,$92,$90,$92,$60,$00
!byte $10,$18,$fc,$fe,$fc,$18,$10,$00
!byte $08,$18,$3f,$7f,$3f,$18,$08,$00


; 0-95 - bert (96)
;   8x orientations
;   4x 16px
;   3x layers

; coily  (32)
;   6x backgrounds (3x each direction) 2x for large and 1x for small
;   4x 16px
;   + 2x4 for eyes?

; balls (32)
;   3x sizes (small, med, large)
;   2x squish and expanded
;   4x 16px
;   2x4 for shine?

; exclamation (8)





.gameTable
!text "PLAYER 1"                     ,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,"LEVEL: 1"                     
!text $00,"000000"               ,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,"ROUND: 1"                     
!byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$81,$82,$83,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$c0,$c1,$c2,$c3,$c4,$c5,$00,$00,$00,$00,$00,$00,$00,$a4,$a5,$a6,$a7,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$90,$93,$00,$00,$00,$00,$00,$00,$00,$00,$00,$fe,$fe,$ff,$ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$c6,$c6,$b4,$b7,$c7,$c7,$00,$00,$00,$00,$00,$80,$81,$86,$87,$84,$85,$82,$83,$00,$01,$03,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$a8,$ab,$00,$00,$00,$00,$00,$00,$00,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$00,$02,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $05,$07,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $06,$08,$00,$00,$00,$00,$00,$00,$00,$00,$80,$81,$86,$87,$84,$85,$86,$87,$84,$85,$82,$83,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $05,$07,$00,$00,$00,$00,$00,$00,$00,$00,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $06,$08,$00,$00,$00,$00,$00,$00,$00,$00,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $05,$07,$00,$00,$00,$01,$03,$00,$80,$81,$86,$87,$84,$85,$86,$87,$84,$85,$86,$87,$84,$85,$82,$83,$00,$01,$03,$00,$00,$00,$00,$00
!byte $06,$08,$00,$00,$00,$02,$04,$00,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$00,$02,$04,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$80,$81,$86,$87,$84,$85,$86,$87,$84,$85,$86,$87,$84,$85,$86,$87,$84,$85,$82,$83,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$80,$81,$86,$87,$84,$85,$86,$87,$84,$85,$86,$87,$84,$85,$86,$87,$84,$85,$86,$87,$84,$85,$82,$83,$00,$00,$00,$00
!byte $00,$00,$00,$00,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$00,$00,$00,$00
!byte $00,$00,$00,$00,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$00,$00,$00,$00
!byte $00,$00,$80,$81,$86,$87,$84,$85,$86,$87,$84,$85,$86,$87,$84,$85,$86,$87,$84,$85,$86,$87,$84,$85,$86,$87,$84,$85,$82,$83,$00,$00
!byte $00,$00,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$00,$00
!byte $00,$00,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$00,$00
!byte $00,$00,$a8,$a9,$aa,$ab,$a8,$a9,$aa,$ab,$a8,$a9,$aa,$ab,$a8,$a9,$aa,$ab,$a8,$a9,$aa,$ab,$a8,$a9,$aa,$ab,$a8,$a9,$aa,$ab,$00,$00


;TMS_TRANSPARENT         = $00
;TMS_BLACK               = $01
;TMS_MED_GREEN           = $02
;TMS_LT_GREEN            = $03
;TMS_DK_BLUE             = $04
;TMS_LT_BLUE             = $05
;TMS_DK_RED              = $06
;TMS_CYAN                = $07
;TMS_MED_RED             = $08
;TMS_LT_RED              = $09
;TMS_DK_YELLOW           = $0a
;TMS_LT_YELLOW           = $0b
;TMS_DK_GREEN            = $0c
;TMS_MAGENTA             = $0d
;TMS_GREY                = $0e
;TMS_WHITE               = $0f

.platformPatt:
!byte $00,$00,$00,$00,$00,$07,$3F,$80
!byte $00,$07,$3F,$FE,$3F,$07,$C0,$F8
!byte $00,$00,$00,$00,$00,$E0,$FC,$FE
!byte $7F,$F8,$C0,$01,$03,$1F,$FC,$E0


!macro colorTable c1, c2, c3, c4 {
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
+byteTmsColorFgBg c1, TMS_TRANSPARENT
+byteTmsColorFgBg c1, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_TRANSPARENT, c2
+byteTmsColorFgBg TMS_TRANSPARENT, c2
+byteTmsColorFgBg c3, c2
+byteTmsColorFgBg c3, c2
+byteTmsColorFgBg c3, c4
+byteTmsColorFgBg c3, TMS_CYAN
+byteTmsColorFgBg c3, TMS_CYAN
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_CYAN
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_CYAN


;8, 2, b, 5
;
;!byte $00,$00,$00,$00,$80,$80,$02,$02
;!byte $b2,$b2,$b5,$b7,$b7,$07,$07,$00
;!byte $00,$00,$00,$00,$80,$80,$80,$82
;!byte $85,$85,$75,$75,$7b,$70,$70,$00


+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
+byteTmsColorFgBg c1, TMS_TRANSPARENT
+byteTmsColorFgBg c1, TMS_TRANSPARENT
+byteTmsColorFgBg c1, TMS_TRANSPARENT
+byteTmsColorFgBg c1, c2
+byteTmsColorFgBg c1, c4
+byteTmsColorFgBg c1, c4
+byteTmsColorFgBg TMS_CYAN, c4
+byteTmsColorFgBg TMS_CYAN, c4
+byteTmsColorFgBg TMS_CYAN, c3
+byteTmsColorFgBg TMS_CYAN, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_CYAN, TMS_TRANSPARENT
}

.platformPal1:
+colorTable TMS_MED_RED, TMS_MED_GREEN, TMS_LT_YELLOW, TMS_LT_BLUE
.platformPal2:
+colorTable TMS_MED_GREEN, TMS_LT_YELLOW, TMS_LT_BLUE, TMS_MED_RED
.platformPal3:
+colorTable TMS_LT_YELLOW, TMS_LT_BLUE, TMS_MED_RED, TMS_MED_GREEN
.platformPal4:
+colorTable TMS_LT_BLUE, TMS_MED_RED, TMS_MED_GREEN, TMS_LT_YELLOW

