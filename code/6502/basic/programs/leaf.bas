10 DISPLAY 2: COLOR $31: R=RND(1)
20 T=0:Y=0
30 FOR I=0 TO 6E4
40 X=T:XP=INT(25*Y):YP=INT(-36*X)+96
50 PLOT XP,YP
60 RP=INT(RND(0)*63)
70 GOSUB 130:GOSUB 90:NEXT I
80 GOTO 80
90 IF RP=0 THEN Y=.16*Y:T=0:RETURN
100 IF RP<55 THEN T=.85*X+.04*Y:Y=-.04*X+.85*Y+1.6:RETURN
110 IF RP<59 THEN T=.2*X-.26*Y:Y=.23*X+.22*Y+1.6:RETURN
120 T=-.15*X+.28*Y:Y=.26*X+.24*Y+.44:RETURN
130 IF RP < 21 THEN COLOR $21: RETURN
140 IF RP < 42 THEN COLOR $31: RETURN
150 COLOR $C1: RETURN