; 6502 - TMS9918 Font 1
;
; Copyright (c) 2021 Troy Schrapel
;
; This code is licensed under the MIT license
;
; https://github.com/visrealm/hbc-56
;






















TMS_FONT_DATA:
!byte $00,$00,$00,$00,$00,$00,$00,$00 ; <SPACE>
!byte $18,$3C,$3C,$18,$18,$00,$18,$00 ; !
!byte $6C,$6C,$00,$00,$00,$00,$00,$00 ; "
!byte $6C,$6C,$FE,$6C,$FE,$6C,$6C,$00 ; #
!byte $18,$3E,$60,$3C,$06,$7C,$18,$00 ; $
!byte $00,$C6,$CC,$18,$30,$66,$C6,$00 ; %
!byte $38,$6C,$68,$76,$DC,$CC,$76,$00 ; &
!byte $18,$18,$30,$00,$00,$00,$00,$00 ; '
!byte $0C,$18,$30,$30,$30,$18,$0C,$00 ; (
!byte $30,$18,$0C,$0C,$0C,$18,$30,$00 ; )
!byte $00,$66,$3C,$FF,$3C,$66,$00,$00 ; *
!byte $00,$18,$18,$7E,$18,$18,$00,$00 ; +
!byte $00,$00,$00,$00,$00,$18,$18,$30 ; ,
!byte $00,$00,$00,$7E,$00,$00,$00,$00 ; -
!byte $00,$00,$00,$00,$00,$18,$18,$00 ; .
!byte $03,$06,$0C,$18,$30,$60,$C0,$00 ; /
!byte $3C,$66,$6E,$7E,$76,$66,$3C,$00 ; 0
!byte $18,$38,$18,$18,$18,$18,$7E,$00 ; 1
!byte $3C,$66,$06,$1C,$30,$66,$7E,$00 ; 2
!byte $3C,$66,$06,$1C,$06,$66,$3C,$00 ; 3
!byte $1C,$3C,$6C,$CC,$FE,$0C,$1E,$00 ; 4
!byte $7E,$60,$7C,$06,$06,$66,$3C,$00 ; 5
!byte $1C,$30,$60,$7C,$66,$66,$3C,$00 ; 6
!byte $7E,$66,$06,$0C,$18,$18,$18,$00 ; 7
!byte $3C,$66,$66,$3C,$66,$66,$3C,$00 ; 8
!byte $3C,$66,$66,$3E,$06,$0C,$38,$00 ; 9
!byte $00,$18,$18,$00,$00,$18,$18,$00 ; :
!byte $00,$18,$18,$00,$00,$18,$18,$30 ; ;
!byte $0C,$18,$30,$60,$30,$18,$0C,$00 ; <
!byte $00,$00,$7E,$00,$00,$7E,$00,$00 ; =
!byte $30,$18,$0C,$06,$0C,$18,$30,$00 ; >
!byte $3C,$66,$06,$0C,$18,$00,$18,$00 ; ?
!byte $7C,$C6,$DE,$DE,$DE,$C0,$78,$00 ; @
!byte $18,$3C,$3C,$66,$7E,$C3,$C3,$00 ; A
!byte $FC,$66,$66,$7C,$66,$66,$FC,$00 ; B
!byte $3C,$66,$C0,$C0,$C0,$66,$3C,$00 ; C
!byte $F8,$6C,$66,$66,$66,$6C,$F8,$00 ; D
!byte $FE,$66,$60,$78,$60,$66,$FE,$00 ; E
!byte $FE,$66,$60,$78,$60,$60,$F0,$00 ; F
!byte $3C,$66,$C0,$CE,$C6,$66,$3E,$00 ; G
!byte $66,$66,$66,$7E,$66,$66,$66,$00 ; H
!byte $7E,$18,$18,$18,$18,$18,$7E,$00 ; I
!byte $0E,$06,$06,$06,$66,$66,$3C,$00 ; J
!byte $E6,$66,$6C,$78,$6C,$66,$E6,$00 ; K
!byte $F0,$60,$60,$60,$62,$66,$FE,$00 ; L
!byte $82,$C6,$EE,$FE,$D6,$C6,$C6,$00 ; M
!byte $C6,$E6,$F6,$DE,$CE,$C6,$C6,$00 ; N
!byte $38,$6C,$C6,$C6,$C6,$6C,$38,$00 ; O
!byte $FC,$66,$66,$7C,$60,$60,$F0,$00 ; P
!byte $38,$6C,$C6,$C6,$C6,$6C,$3C,$06 ; Q
!byte $FC,$66,$66,$7C,$6C,$66,$E3,$00 ; R
!byte $3C,$66,$70,$38,$0E,$66,$3C,$00 ; S
!byte $7E,$5A,$18,$18,$18,$18,$3C,$00 ; T
!byte $66,$66,$66,$66,$66,$66,$3E,$00 ; U
!byte $C3,$C3,$66,$66,$3C,$3C,$18,$00 ; V
!byte $C6,$C6,$C6,$D6,$FE,$EE,$C6,$00 ; W
!byte $C3,$66,$3C,$18,$3C,$66,$C3,$00 ; X
!byte $C3,$C3,$66,$3C,$18,$18,$3C,$00 ; Y
!byte $FE,$C6,$8C,$18,$32,$66,$FE,$00 ; Z
!byte $3C,$30,$30,$30,$30,$30,$3C,$00 ; [
!byte $C0,$60,$30,$18,$0C,$06,$03,$00 ; \
!byte $3C,$0C,$0C,$0C,$0C,$0C,$3C,$00 ; ]
!byte $10,$38,$6C,$C6,$00,$00,$00,$00 ; ^
!byte $00,$00,$00,$00,$00,$00,$00,$FE ; _
!byte $18,$18,$0C,$00,$00,$00,$00,$00 ; `
!byte $00,$00,$3C,$06,$1E,$66,$3B,$00 ; a
!byte $E0,$60,$6C,$76,$66,$66,$3C,$00 ; b
!byte $00,$00,$3C,$66,$60,$66,$3C,$00 ; c
!byte $0E,$06,$36,$6E,$66,$66,$3B,$00 ; d
!byte $00,$00,$3C,$66,$7E,$60,$3C,$00 ; e
!byte $1C,$36,$30,$78,$30,$30,$78,$00 ; f
!byte $00,$00,$3B,$66,$66,$3C,$C6,$7C ; g
!byte $E0,$60,$6C,$76,$66,$66,$E6,$00 ; h
!byte $18,$00,$38,$18,$18,$18,$3C,$00 ; i
!byte $06,$00,$06,$06,$06,$06,$66,$3C ; j
!byte $E0,$60,$66,$6C,$78,$6C,$E6,$00 ; k
!byte $38,$18,$18,$18,$18,$18,$3C,$00 ; l
!byte $00,$00,$66,$77,$6B,$63,$63,$00 ; m
!byte $00,$00,$7C,$66,$66,$66,$66,$00 ; n
!byte $00,$00,$3C,$66,$66,$66,$3C,$00 ; o
!byte $00,$00,$DC,$66,$66,$7C,$60,$F0 ; p
!byte $00,$00,$3D,$66,$66,$3E,$06,$07 ; q
!byte $00,$00,$EC,$76,$66,$60,$F0,$00 ; r
!byte $00,$00,$3E,$60,$3C,$06,$7C,$00 ; s
!byte $10,$30,$7C,$30,$30,$34,$18,$00 ; t
!byte $00,$00,$CC,$CC,$CC,$CC,$76,$00 ; u
!byte $00,$00,$CC,$CC,$CC,$78,$30,$00 ; v
!byte $00,$00,$C6,$D6,$D6,$6C,$6C,$00 ; w
!byte $00,$00,$63,$36,$1C,$36,$63,$00 ; x
!byte $00,$00,$66,$66,$66,$3C,$18,$70 ; y
!byte $00,$00,$7E,$4C,$18,$32,$7E,$00 ; z
!byte $0E,$18,$18,$70,$18,$18,$0E,$00 ; {
!byte $18,$18,$18,$18,$18,$18,$18,$00 ; |
!byte $70,$18,$18,$0E,$18,$18,$70,$00 ; }
!byte $72,$9C,$00,$00,$00,$00,$00,$00 ; ~
!byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff ;  