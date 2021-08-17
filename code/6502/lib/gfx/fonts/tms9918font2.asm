; 6502 - TMS9918 Font 2 (0 -255)
;
; Copyright (c) 2021 Troy Schrapel
;
; This code is licensed under the MIT license
;
; https://github.com/visrealm/hbc-56
;
TMS_FONT_DATA:
!byte $00,$00,$00,$00,$00,$00,$00,$00,$38,$44,$6C,$44,$54,$44,$38,$00,$38,$7C,$54,$7C,$44,$7C,$38,$00,$00,$28,$7C,$7C,$7C,$38,$10,$00,$00,$10,$38,$7C,$7C,$38,$10,$00
!byte $10,$38,$38,$10,$7C,$7C,$10,$00,$00,$10,$38,$7C,$7C,$10,$38,$00,$00,$00,$00,$30,$30,$00,$00,$00,$FC,$FC,$FC,$CC,$CC,$FC,$FC,$FC,$00,$00,$78,$48,$48,$78,$00,$00
!byte $FC,$FC,$84,$B4,$B4,$84,$FC,$FC,$00,$1C,$0C,$34,$48,$48,$30,$00,$38,$44,$44,$38,$10,$38,$10,$00
!byte $10,$18,$14,$10,$30,$70,$60,$00
!byte $0C,$34,$2C,$34,$2C,$6C,$60,$00
!byte $00,$54,$38,$6C,$38,$54,$00,$00
!byte $20,$30,$38,$3C,$38,$30,$20,$00
!byte $08,$18,$38,$78,$38,$18,$08,$00
!byte $10,$38,$7C,$10,$7C,$38,$10,$00
!byte $28,$28,$28,$28,$28,$00,$28,$00
!byte $3C,$54,$54,$34,$14,$14,$14,$00
!byte $38,$44,$30,$28,$18,$44,$38,$00
!byte $00,$00,$00,$00,$00,$78,$78,$00
!byte $10,$38,$7C,$10,$7C,$38,$10,$38
!byte $10,$38,$7C,$10,$10,$10,$10,$00
!byte $10,$10,$10,$10,$7C,$38,$10,$00
!byte $00,$10,$18,$7C,$18,$10,$00,$00
!byte $00,$10,$30,$7C,$30,$10,$00,$00
!byte $00,$00,$00,$40,$40,$40,$7C,$00
!byte $00,$28,$28,$7C,$28,$28,$00,$00
!byte $10,$10,$38,$38,$7C,$7C,$00,$00
!byte $7C,$7C,$38,$38,$10,$10,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00 ; <SPACE>
!byte $10,$38,$38,$10,$10,$00,$10,$00 ; !
!byte $6C,$6C,$48,$00,$00,$00,$00,$00 ; "
!byte $00,$28,$7C,$28,$28,$7C,$28,$00 ; #
!byte $20,$38,$40,$30,$08,$70,$10,$00 ; $
!byte $64,$64,$08,$10,$20,$4C,$4C,$00 ; %
!byte $20,$50,$50,$20,$54,$48,$34,$00 ; &
!byte $30,$30,$20,$00,$00,$00,$00,$00 ; '
!byte $10,$20,$20,$20,$20,$20,$10,$00 ; (
!byte $20,$10,$10,$10,$10,$10,$20,$00 ; )
!byte $00,$28,$38,$7C,$38,$28,$00,$00 ; *
!byte $00,$10,$10,$7C,$10,$10,$00,$00 ; +
!byte $00,$00,$00,$00,$00,$30,$30,$20 ; ,
!byte $00,$00,$00,$7C,$00,$00,$00,$00 ; -
!byte $00,$00,$00,$00,$00,$30,$30,$00 ; .
!byte $00,$04,$08,$10,$20,$40,$00,$00 ; /
!byte $38,$44,$4C,$54,$64,$44,$38,$00 ; 0
!byte $10,$30,$10,$10,$10,$10,$38,$00 ; 1
!byte $38,$44,$04,$18,$20,$40,$7C,$00 ; 2
!byte $38,$44,$04,$38,$04,$44,$38,$00 ; 3
!byte $08,$18,$28,$48,$7C,$08,$08,$00 ; 4
!byte $7C,$40,$40,$78,$04,$44,$38,$00 ; 5
!byte $18,$20,$40,$78,$44,$44,$38,$00 ; 6
!byte $7C,$04,$08,$10,$20,$20,$20,$00 ; 7
!byte $38,$44,$44,$38,$44,$44,$38,$00 ; 8
!byte $38,$44,$44,$3C,$04,$08,$30,$00 ; 9
!byte $00,$00,$30,$30,$00,$30,$30,$00 ; :
!byte $00,$00,$30,$30,$00,$30,$30,$20 ; ;
!byte $08,$10,$20,$40,$20,$10,$08,$00 ; <
!byte $00,$00,$7C,$00,$00,$7C,$00,$00 ; =
!byte $20,$10,$08,$04,$08,$10,$20,$00 ; >
!byte $38,$44,$04,$18,$10,$00,$10,$00 ; ?
!byte $38,$44,$5C,$54,$5C,$40,$38,$00 ; @
!byte $38,$44,$44,$44,$7C,$44,$44,$00 ; A
!byte $78,$44,$44,$78,$44,$44,$78,$00 ; B
!byte $38,$44,$40,$40,$40,$44,$38,$00 ; C
!byte $78,$44,$44,$44,$44,$44,$78,$00 ; D
!byte $7C,$40,$40,$78,$40,$40,$7C,$00 ; E
!byte $7C,$40,$40,$78,$40,$40,$40,$00 ; F
!byte $38,$44,$40,$5C,$44,$44,$3C,$00 ; G
!byte $44,$44,$44,$7C,$44,$44,$44,$00 ; H
!byte $38,$10,$10,$10,$10,$10,$38,$00 ; I
!byte $04,$04,$04,$04,$44,$44,$38,$00 ; J
!byte $44,$48,$50,$60,$50,$48,$44,$00 ; K
!byte $40,$40,$40,$40,$40,$40,$7C,$00 ; L
!byte $44,$6C,$54,$44,$44,$44,$44,$00 ; M
!byte $44,$64,$54,$4C,$44,$44,$44,$00 ; N
!byte $38,$44,$44,$44,$44,$44,$38,$00 ; O
!byte $78,$44,$44,$78,$40,$40,$40,$00 ; P
!byte $38,$44,$44,$44,$54,$48,$34,$00 ; Q
!byte $78,$44,$44,$78,$48,$44,$44,$00 ; R
!byte $38,$44,$40,$38,$04,$44,$38,$00 ; S
!byte $7C,$10,$10,$10,$10,$10,$10,$00 ; T
!byte $44,$44,$44,$44,$44,$44,$38,$00 ; U
!byte $44,$44,$44,$44,$44,$28,$10,$00 ; V
!byte $44,$44,$54,$54,$54,$54,$28,$00 ; W
!byte $44,$44,$28,$10,$28,$44,$44,$00 ; X
!byte $44,$44,$44,$28,$10,$10,$10,$00 ; Y
!byte $78,$08,$10,$20,$40,$40,$78,$00 ; Z
!byte $38,$20,$20,$20,$20,$20,$38,$00 ; [
!byte $00,$40,$20,$10,$08,$04,$00,$00 ; \
!byte $38,$08,$08,$08,$08,$08,$38,$00 ; ]
!byte $10,$28,$44,$00,$00,$00,$00,$00 ; ^
!byte $00,$00,$00,$00,$00,$00,$00,$FC ; _
!byte $30,$30,$10,$00,$00,$00,$00,$00 ; `
!byte $00,$00,$38,$04,$3C,$44,$3C,$00 ; a
!byte $40,$40,$78,$44,$44,$44,$78,$00 ; b
!byte $00,$00,$38,$44,$40,$44,$38,$00 ; c
!byte $04,$04,$3C,$44,$44,$44,$3C,$00 ; d
!byte $00,$00,$38,$44,$78,$40,$38,$00 ; e
!byte $18,$20,$20,$78,$20,$20,$20,$00 ; f
!byte $00,$00,$3C,$44,$44,$3C,$04,$38 ; g
!byte $40,$40,$70,$48,$48,$48,$48,$00 ; h
!byte $10,$00,$10,$10,$10,$10,$18,$00 ; i
!byte $08,$00,$18,$08,$08,$08,$48,$30 ; j
!byte $40,$40,$48,$50,$60,$50,$48,$00 ; k
!byte $10,$10,$10,$10,$10,$10,$18,$00 ; l
!byte $00,$00,$68,$54,$54,$44,$44,$00 ; m
!byte $00,$00,$70,$48,$48,$48,$48,$00 ; n
!byte $00,$00,$38,$44,$44,$44,$38,$00 ; o
!byte $00,$00,$78,$44,$44,$44,$78,$40 ; p
!byte $00,$00,$3C,$44,$44,$44,$3C,$04 ; q
!byte $00,$00,$58,$24,$20,$20,$70,$00 ; r
!byte $00,$00,$38,$40,$38,$04,$38,$00 ; s
!byte $00,$20,$78,$20,$20,$28,$10,$00 ; t
!byte $00,$00,$48,$48,$48,$58,$28,$00 ; u
!byte $00,$00,$44,$44,$44,$28,$10,$00 ; v
!byte $00,$00,$44,$44,$54,$7C,$28,$00 ; w
!byte $00,$00,$48,$48,$30,$48,$48,$00 ; x
!byte $00,$00,$48,$48,$48,$38,$10,$60 ; y
!byte $00,$00,$78,$08,$30,$40,$78,$00 ; z
!byte $18,$20,$20,$60,$20,$20,$18,$00 ; {
!byte $10,$10,$10,$00,$10,$10,$10,$00 ; |
!byte $30,$08,$08,$0C,$08,$08,$30,$00 ; }
!byte $28,$50,$00,$00,$00,$00,$00,$00 ; ~
!byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff ;
!byte $38,$44,$40,$40,$44,$38,$10,$30
!byte $48,$00,$48,$48,$48,$58,$28,$00
!byte $0C,$00,$38,$44,$78,$40,$38,$00
!byte $38,$00,$38,$04,$3C,$44,$3C,$00
!byte $28,$00,$38,$04,$3C,$44,$3C,$00
!byte $30,$00,$38,$04,$3C,$44,$3C,$00
!byte $38,$28,$38,$04,$3C,$44,$3C,$00
!byte $00,$38,$44,$40,$44,$38,$10,$30
!byte $38,$00,$38,$44,$78,$40,$38,$00
!byte $28,$00,$38,$44,$78,$40,$38,$00
!byte $30,$00,$38,$44,$78,$40,$38,$00
!byte $28,$00,$10,$10,$10,$10,$18,$00
!byte $10,$28,$00,$10,$10,$10,$18,$00
!byte $20,$00,$10,$10,$10,$10,$18,$00
!byte $28,$00,$10,$28,$44,$7C,$44,$00
!byte $38,$28,$38,$6C,$44,$7C,$44,$00
!byte $0C,$00,$7C,$40,$78,$40,$7C,$00
!byte $00,$00,$78,$14,$7C,$50,$3C,$00
!byte $3C,$50,$50,$7C,$50,$50,$5C,$00
!byte $38,$00,$30,$48,$48,$48,$30,$00
!byte $28,$00,$30,$48,$48,$48,$30,$00
!byte $60,$00,$30,$48,$48,$48,$30,$00
!byte $38,$00,$48,$48,$48,$58,$28,$00
!byte $60,$00,$48,$48,$48,$58,$28,$00
!byte $28,$00,$48,$48,$48,$38,$10,$60
!byte $48,$30,$48,$48,$48,$48,$30,$00
!byte $28,$00,$48,$48,$48,$48,$30,$00
!byte $00,$10,$38,$40,$40,$38,$10,$00
!byte $18,$24,$20,$78,$20,$24,$5C,$00
!byte $44,$28,$10,$7C,$10,$7C,$10,$00
!byte $60,$50,$50,$68,$5C,$48,$48,$00
!byte $08,$14,$10,$38,$10,$10,$50,$20
!byte $18,$00,$38,$04,$3C,$44,$3C,$00
!byte $18,$00,$10,$10,$10,$10,$18,$00
!byte $18,$00,$30,$48,$48,$48,$30,$00
!byte $18,$00,$48,$48,$48,$58,$28,$00
!byte $28,$50,$00,$70,$48,$48,$48,$00
!byte $28,$50,$00,$48,$68,$58,$48,$00
!byte $38,$04,$3C,$44,$3C,$00,$3C,$00
!byte $30,$48,$48,$48,$30,$00,$78,$00
!byte $10,$00,$10,$30,$40,$44,$38,$00
!byte $00,$00,$7C,$40,$40,$40,$00,$00
!byte $00,$00,$FC,$04,$04,$00,$00,$00
!byte $40,$48,$50,$38,$44,$08,$1C,$00
!byte $40,$48,$50,$2C,$54,$1C,$04,$00
!byte $10,$00,$10,$10,$38,$38,$10,$00
!byte $00,$00,$24,$48,$24,$00,$00,$00
!byte $00,$00,$48,$24,$48,$00,$00,$00
!byte $54,$00,$A8,$00,$54,$00,$A8,$00
!byte $54,$A8,$54,$A8,$54,$A8,$54,$A8
!byte $A8,$FC,$54,$FC,$A8,$FC,$54,$FC
!byte $10,$10,$10,$10,$10,$10,$10,$10
!byte $10,$10,$10,$F0,$10,$10,$10,$10
!byte $10,$F0,$10,$F0,$10,$10,$10,$10
!byte $50,$50,$50,$D0,$50,$50,$50,$50
!byte $00,$00,$00,$F0,$50,$50,$50,$50
!byte $00,$F0,$10,$F0,$10,$10,$10,$10
!byte $50,$D0,$10,$D0,$50,$50,$50,$50
!byte $50,$50,$50,$50,$50,$50,$50,$50
!byte $00,$F0,$10,$D0,$50,$50,$50,$50
!byte $50,$D0,$10,$F0,$00,$00,$00,$00
!byte $50,$50,$50,$F0,$00,$00,$00,$00
!byte $10,$F0,$10,$F0,$00,$00,$00,$00
!byte $00,$00,$00,$F0,$10,$10,$10,$10
!byte $10,$10,$10,$1C,$00,$00,$00,$00
!byte $10,$10,$10,$FC,$00,$00,$00,$00
!byte $00,$00,$00,$FC,$10,$10,$10,$10
!byte $10,$10,$10,$1C,$10,$10,$10,$10
!byte $00,$00,$00,$FC,$00,$00,$00,$00
!byte $10,$10,$10,$FC,$10,$10,$10,$10
!byte $10,$1C,$10,$1C,$10,$10,$10,$10
!byte $50,$50,$50,$5C,$50,$50,$50,$50
!byte $50,$5C,$40,$7C,$00,$00,$00,$00
!byte $00,$7C,$40,$5C,$50,$50,$50,$50
!byte $50,$DC,$00,$FC,$00,$00,$00,$00
!byte $00,$FC,$00,$DC,$50,$50,$50,$50
!byte $50,$5C,$40,$5C,$50,$50,$50,$50
!byte $00,$FC,$00,$FC,$00,$00,$00,$00
!byte $50,$DC,$00,$DC,$50,$50,$50,$50
!byte $10,$FC,$00,$FC,$00,$00,$00,$00
!byte $50,$50,$50,$FC,$00,$00,$00,$00
!byte $00,$FC,$00,$FC,$10,$10,$10,$10
!byte $00,$00,$00,$FC,$50,$50,$50,$50
!byte $50,$50,$50,$7C,$00,$00,$00,$00
!byte $10,$1C,$10,$1C,$00,$00,$00,$00
!byte $00,$1C,$10,$1C,$10,$10,$10,$10
!byte $00,$00,$00,$7C,$50,$50,$50,$50
!byte $50,$50,$50,$DC,$50,$50,$50,$50
!byte $10,$FC,$00,$FC,$10,$10,$10,$10
!byte $10,$10,$10,$F0,$00,$00,$00,$00
!byte $00,$00,$00,$1C,$10,$10,$10,$10
!byte $FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC
!byte $00,$00,$00,$00,$FC,$FC,$FC,$FC
!byte $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0
!byte $1C,$1C,$1C,$1C,$1C,$1C,$1C,$1C
!byte $FC,$FC,$FC,$FC,$00,$00,$00,$00
!byte $00,$00,$34,$48,$48,$34,$00,$00
!byte $00,$70,$48,$70,$48,$48,$70,$40
!byte $78,$48,$40,$40,$40,$40,$40,$00
!byte $00,$7C,$28,$28,$28,$28,$28,$00
!byte $78,$48,$20,$10,$20,$48,$78,$00
!byte $00,$00,$3C,$48,$48,$30,$00,$00
!byte $00,$00,$48,$48,$48,$70,$40,$40
!byte $00,$00,$28,$50,$10,$10,$10,$00
!byte $38,$10,$38,$44,$38,$10,$38,$00
!byte $30,$48,$48,$78,$48,$48,$30,$00
!byte $00,$38,$44,$44,$28,$28,$6C,$00
!byte $30,$40,$20,$10,$38,$48,$30,$00
!byte $00,$00,$28,$54,$54,$28,$00,$00
!byte $00,$10,$38,$54,$54,$38,$10,$00
!byte $00,$38,$40,$78,$40,$38,$00,$00
!byte $00,$30,$48,$48,$48,$48,$00,$00
!byte $00,$78,$00,$78,$00,$78,$00,$00
!byte $00,$10,$38,$10,$00,$38,$00,$00
!byte $40,$30,$08,$30,$40,$00,$78,$00
!byte $08,$30,$40,$30,$08,$00,$78,$00
!byte $00,$08,$14,$10,$10,$10,$10,$10
!byte $10,$10,$10,$10,$10,$50,$20,$00
!byte $00,$10,$00,$7C,$00,$10,$00,$00
!byte $00,$28,$50,$00,$28,$50,$00,$00
!byte $30,$48,$48,$30,$00,$00,$00,$00
!byte $00,$00,$00,$30,$30,$00,$00,$00
!byte $00,$00,$00,$20,$00,$00,$00,$00
!byte $00,$1C,$10,$10,$50,$50,$20,$00
!byte $50,$28,$28,$28,$00,$00,$00,$00
!byte $60,$10,$20,$70,$00,$00,$00,$00
!byte $00,$00,$78,$78,$78,$78,$00,$00
!byte $00,$00,$00,$00,$00,$00,$00,$00