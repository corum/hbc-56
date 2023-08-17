

; Troy's HBC-56 - Breakout
;
; Copyright (c) 2022 Troy Schrapel
;
; This code is licensed under the MIT license
;
; https://github.com/visrealm/hbc-56
;

!src "hbc56kernel.inc"

; Zero page addresses
; -------------------------
ZP0 = HBC56_USER_ZP_START

QBERT_STATE   = ZP0
QBERT_DIR     = ZP0 + 1
QBERT_ANIM    = ZP0 + 2
QBERT_X       = ZP0 + 3
QBERT_Y       = ZP0 + 4

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
        +tmsColorFgBg TMS_WHITE, TMS_BLACK
        jsr tmsSetBackground


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

        lda #122
        sta QBERT_X
        lda #12
        sta QBERT_Y

        jsr .bertSpriteRightRest

        cli

        jmp hbc56Stop

.bertSpriteRightRest:
        +tmsCreateSprite 0, 0, 122, 8, TMS_LT_RED
        +tmsCreateSprite 1, 4, 122, 12, TMS_BLACK
        +tmsCreateSprite 2, 8, 122, -3, TMS_WHITE
        jmp .updateBertSpriteRest

.bertSpriteRightJump
        +tmsCreateSprite 0, 12, 122, 7, TMS_LT_RED
        +tmsCreateSprite 1, 16, 122, 10, TMS_BLACK
        +tmsCreateSprite 2, 20, 122, -6, TMS_WHITE
        jmp .updateBertSpriteJump

.updateBertSpriteRest
        ldx QBERT_X
        ldy QBERT_Y
        +tmsSpritePosXYReg 1
        dey
        dey
        dey
        dey
        +tmsSpritePosXYReg 0
        tya
        clc
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
        tya
        clc
        adc #-13
        tay
        +tmsSpritePosXYReg 2
        rts


.rightPressed:
        lda #1
        sta QBERT_STATE
        jsr .bertSpriteRightJump
        rts

.updatePos:

        ldx QBERT_ANIM
        clc
        lda QBERT_X
        adc .bertJumpAnimX,X
        sta QBERT_X

        clc
        lda QBERT_Y
        adc .bertJumpAnimY,X
        sta QBERT_Y

        jsr .updateBertSpriteJump

        lda QBERT_ANIM
        inc
        sta QBERT_ANIM
        bit #$10
        beq +
        stz QBERT_STATE
        stz QBERT_ANIM
        jsr .bertSpriteRightRest
+
        jmp .afterControl
gameLoop:

        lda QBERT_STATE
        bne .updatePos
        +nes1BranchIfPressed NES_RIGHT, .rightPressed

.afterControl

        lda HBC56_TICKS

        cmp #15
        bcs +
        jmp updateColor1
+
        cmp #30
        bcs +
        jmp updateColor2
+
        cmp #45
        bcs +
        jmp updateColor3
+
        jmp updateColor4


        +nes1BranchIfPressed NES_RIGHT, .rightPressed



        rts

updateColor1:
        +tmsSetAddrColorTableIIBank0 1
        +tmsSendData .color1, 8 * 4

        +tmsSetAddrColorTableIIBank1 1
        +tmsSendData .color1, 8 * 4

        ;+tmsSetAddrColorTableIIBank2 1
        ;+tmsSendData .color1, 8 * 4
        rts

updateColor2:
        +tmsSetAddrColorTableIIBank0 1
        +tmsSendData .color2, 8 * 4

        +tmsSetAddrColorTableIIBank1 1
        +tmsSendData .color2, 8 * 4

        ;+tmsSetAddrColorTableIIBank2 1
        ;+tmsSendData .color2, 8 * 4
        rts

updateColor3:
        +tmsSetAddrColorTableIIBank0 1
        +tmsSendData .color3, 8 * 4

        +tmsSetAddrColorTableIIBank1 1
        +tmsSendData .color3, 8 * 4

        ;+tmsSetAddrColorTableIIBank2 1
        ;+tmsSendData .color3, 8 * 4
        rts

updateColor4:
        +tmsSetAddrColorTableIIBank0 1
        +tmsSendData .color4, 8 * 4

        +tmsSetAddrColorTableIIBank1 1
        +tmsSendData .color4, 8 * 4

        ;+tmsSetAddrColorTableIIBank2 1
        ;+tmsSendData .color4, 8 * 4
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
        +tmsSendData .pattern, 8 * 4
        +tmsSendData .bertCharPatt, 8 * 4

        +tmsSetAddrPattTableIIBank1 1
        +tmsSendData .pattern, 8 * 4

        +tmsSetAddrPattTableIIBank2 1
        +tmsSendData .pattern, 8 * 4


        ; brick colors (for each bank)
        +tmsSetAddrColorTableIIBank0 1
        +tmsSendData .color2, 8 * 4
        +tmsSendData .bertCharColor, 8 * 4

        +tmsSetAddrColorTableIIBank1 1
        +tmsSendData .color2, 8 * 4

        +tmsSetAddrColorTableIIBank2 1
        +tmsSendData .color2, 8 * 4        

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
        +tmsSendData .bertPattR, 8 * 4 * 3 * 2

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
        +tmsPutRpt $80, 8 * 4
        +tmsPutRpt $8e, 8 * 2
        +tmsPutRpt $8f, 8 * 2
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
        +tmsPutRpt $f0, 8 * 2
        +tmsPutRpt $e0, 8 * 2
        +tmsPutRpt $8f, 8 * 2
        +tmsPutRpt $8e, 8 * 2
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



.pattern:
!byte $00,$00,$00,$07,$3F,$80,$00,$07
!byte $3F,$FE,$3F,$07,$C0,$F8,$00,$00
!byte $00,$00,$00,$E0,$FC,$FE,$7F,$F8
!byte $C0,$01,$03,$1F,$FC,$E0,$00,$00

.bertCharPatt:
!byte $00,$00,$3e,$7f,$e4,$e4,$ff,$ff
!byte $ff,$7f,$3f,$22,$22,$22,$33,$19
!byte $00,$00,$00,$00,$00,$00,$c0,$e0
!byte $f0,$c8,$48,$30,$00,$00,$00,$80

.bertCharColor:
!byte $80,$80,$80,$80,$8f,$81,$80,$80
!byte $80,$80,$80,$80,$80,$80,$80,$80
!byte $80,$80,$80,$80,$80,$80,$80,$80
!byte $80,$80,$80,$80,$80,$80,$80,$80


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

!byte $06,$06,$00,$00,$00,$00,$00,$00  ; black offset y+4
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $c0,$c0,$00,$00,$00,$00,$0c,$0c
!byte $00,$00,$00,$00,$00,$00,$00,$00

!byte $00,$00,$00,$00,$00,$00,$00,$00  ; white offset y-13
!byte $00,$00,$00,$00,$00,$00,$00,$06
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$c0


!byte $0F,$3F,$7F,$79,$F9,$FF,$FF,$FF   ; red
!byte $7F,$3F,$1F,$11,$11,$11,$39,$1E
!byte $00,$C0,$C0,$00,$20,$F8,$FC,$FE
!byte $B2,$12,$0C,$00,$00,$00,$C0,$70

!byte $06,$06,$00,$00,$00,$00,$00,$00   ; black offset y+3
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $C0,$C0,$00,$00,$00,$0C,$0C,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00

!byte $00,$00,$00,$00,$00,$00,$00,$00   ; white offset y-13
!byte $00,$00,$00,$00,$00,$00,$00,$06
!byte $00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$C0


.bertJumpAnimX
!byte 0,0,1,1,2,2,2,2,2,1,1,1,1,0,0,0
.bertJumpAnimY
!byte 0,-3,-2,-1,0,1,2,3,3,3,3,3,3,3,3,3



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
!text $00,"000000"               ,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$03,$00,$00,$00,$00,"ROUND: 1"                     
!byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$81,$82,$83,$02,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$88,$89,$8a,$8b,$00,$00,$00,$00,$00,$00,$00,$00,$a4,$a5,$a6,$a7,$00,$00,$00,$00,$00,$00,$00,$00,$05,$07,$05,$07,$05,$07
!byte $00,$00,$ac,$ad,$ae,$af,$00,$00,$00,$00,$00,$00,$00,$00,$fe,$fe,$ff,$ff,$00,$00,$00,$00,$00,$00,$00,$00,$06,$08,$06,$08,$06,$08
!byte $00,$00,$a8,$a9,$aa,$ab,$00,$00,$00,$00,$00,$00,$80,$81,$86,$87,$84,$85,$82,$83,$00,$01,$03,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$00,$02,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$81,$86,$87,$84,$85,$86,$87,$84,$85,$82,$83,$00,$01,$03,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$00,$02,$04,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$fe,$fe,$ff,$ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$01,$03,$00,$80,$81,$86,$87,$84,$85,$86,$87,$84,$85,$86,$87,$84,$85,$82,$83,$00,$01,$03,$00,$00,$00,$00,$00
!byte $00,$00,$00,$00,$00,$02,$04,$00,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$a4,$a5,$a6,$a7,$00,$02,$04,$00,$00,$00,$00,$00
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

!macro colorTable c1, c2, c3, c4 {
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
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
+byteTmsColorFgBg TMS_TRANSPARENT, TMS_TRANSPARENT
}

.color1:
+colorTable TMS_MED_RED, TMS_MED_GREEN, TMS_LT_YELLOW, TMS_LT_BLUE
.color2:
+colorTable TMS_MED_GREEN, TMS_LT_YELLOW, TMS_LT_BLUE, TMS_MED_RED
.color3:
+colorTable TMS_LT_YELLOW, TMS_LT_BLUE, TMS_MED_RED, TMS_MED_GREEN
.color4:
+colorTable TMS_LT_BLUE, TMS_MED_RED, TMS_MED_GREEN, TMS_LT_YELLOW

