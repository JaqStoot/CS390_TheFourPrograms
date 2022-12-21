10 DIM arrassignname$(20)
11 DIM arrcategory$(20) 
13 DIM arrposspoints(20)
14 DIM arrearnpoints(20)
15 pctn = 0.0
16 earnpointstemp = 0
17 posspointstotal = 0
18 earnpointstotal = 0
19 groupprojecttotal = 0
20 homeworktotal = 0
21 progtotal = 0
22 quizzestotal = 0
23 totalpoints = 0
24 inttotalpoints = 0
26 groupprojectearn = 0
27 homeworkearn = 0
28 progearn = 0
29 quizzesearn = 0
30 currentgrade = 0
31 minfinalgrade = 0
32 minfinalgrade = 0
33 start = 0

100 INPUT "File: "; F$
110 OPEN F$ FOR INPUT AS #1
111 LINE INPUT #1, fl$
112 totalpoints = VAL(fl$)
119 REM Read in line from file

120 FOR I=1 TO 100
122 LINE INPUT #1, l$
130 IF l$ = " " THEN PRINT:GOTO 1000

139 REM Get ASSIGMENT NAME
140 FOR J=1 TO 100
141 IF MID$(l$,J,2) <> "  " THEN GOTO 147
143 arrassignname$(I) = MID$(l$,1,J)
146 J = 100
147 NEXT J

149 REM Get CATEGORY
150 FOR J=21 TO 100
151 IF MID$(l$,J,2) <> "  " THEN GOTO 156
153 arrcategory$(I) = MID$(l$,21,J-20)
155 J = 100
156 NEXT J

159 REM Get POINTS POSSIBLE
160 FOR J=41 TO 100
161 IF MID$(l$,J,2) <> "  " THEN GOTO 166
163 arrposspoints(I) = VAL(MID$(l$,41,J-41))
165 J = 100
166 NEXT J

169 REM Get POINTS EARNED
170 FOR J=55 TO 100
171 IF MID$(l$,J, 2) <> "  " THEN GOTO 176
173 arrearnpoints(I) = VAL(MID$(l$,55,J-55))
175 J = 100
176 NEXT J

500 NEXT I

999 length = 0
1000 FOR I = 1 TO 20
1010 IF arrposspoints(I) <> 0 THEN GOTO 1050
1020 length = I-1
1030 I = 20
1050 NEXT I

1100 FOR I = 1 to length

1110 IF arrcategory$(I) <> "Group Project " THEN GOTO 1200
1120 groupprojecttotal = groupprojecttotal + arrposspoints(I)
1130 groupprojectearn = groupprojectearn + arrearnpoints(I)
1140 earnpointstotal = earnpointstotal + arrearnpoints(I)
1150 posspointstotal = posspointstotal + arrposspoints(I)
1160 GOTO 1500

1200 IF arrcategory$(I) <> "Programming " THEN GOTO 1300
1210 progtotal = progtotal + arrposspoints(I)
1220 progearn = progearn + arrearnpoints(I)
1230 earnpointstotal = earnpointstotal + arrearnpoints(I)
1240 posspointstotal = posspointstotal + arrposspoints(I)
1250 GOTO 1500

1300 IF arrcategory$(I) <> "Quizzes " THEN GOTO 1400
1310 quizzestotal = quizzestotal + arrposspoints(I)
1320 quizzesearn = quizzesearn + arrearnpoints(I)
1330 earnpointstotal = earnpointstotal + arrearnpoints(I)
1340 posspointstotal = posspointstotal + arrposspoints(I)
1350 GOTO 1500

1400 IF arrcategory$(I) <> "Homework " THEN GOTO 1500
1410 homeworktotal = homeworktotal + arrposspoints(I)
1420 homeworkearn = homeworkearn + arrearnpoints(I)
1430 earnpointstotal = earnpointstotal + arrearnpoints(I)
1440 posspointstotal = posspointstotal + arrposspoints(I)

1500 NEXT I



2000 print "GROUP PROJECT"
2010 print "============================================"
2020 FOR I = 1 to length
2030 IF arrcategory$(I) <> "Group Project " THEN GOTO 2060
2040 pcnt = (arrearnpoints(I)*100)/arrposspoints(I)
2050 print arrassignname$(I);"     ";arrearnpoints(I);"/";arrposspoints(I);"   ";pcnt;"%"
2060 NEXT I
2070 print "============================================"
2075 pcnt = (groupprojectearn*100)/groupprojecttotal
2080 print "                               ";groupprojectearn;"/";groupprojecttotal;"  ";pcnt;"%"
2090 print ""

2100 print "HOMEWORK"
2110 print "============================================"
2120 FOR I = 1 to length
2130 IF arrcategory$(I) <> "Homework " THEN GOTO 2160
2140 pcnt = (arrearnpoints(I)*100)/arrposspoints(I)
2150 print arrassignname$(I);"     ";arrearnpoints(I);"/";arrposspoints(I);"   ";pcnt;"%"
2160 NEXT I
2170 print "============================================"
2175 pcnt = (homeworkearn*100)/homeworktotal
2180 print "                               ";homeworkearn;"/";homeworktotal;"  ";pcnt;"%"
2190 print ""

2200 print "PROGRAMMING"
2210 print "============================================"
2220 FOR I = 1 to length
2230 IF arrcategory$(I) <> "Programming " THEN GOTO 2260
2240 pcnt = (arrearnpoints(I)*100)/arrposspoints(I)
2250 print arrassignname$(I);"     ";arrearnpoints(I);"/";arrposspoints(I);"   ";pcnt;"%"
2260 NEXT I
2270 print "============================================"
2275 pcnt = (progearn*100)/progtotal
2280 print "                               ";progearn;"/";progtotal;"  ";pcnt;"%"
2290 print ""

2300 print "QUIZZES"
2310 print "============================================"
2320 FOR I = 1 to length
2330 IF arrcategory$(I) <> "Quizzes " THEN GOTO 2360
2340 pcnt = (arrearnpoints(I)*100)/arrposspoints(I)
2350 print arrassignname$(I);"     ";arrearnpoints(I);"/";arrposspoints(I);"   ";pcnt;"%"
2360 NEXT I
2370 print "============================================"
2375 pcnt = (quizzesearn*100)/quizzestotal
2380 print "                               ";quizzesearn;"/";quizzestotal;"  ";pcnt;"%"
2390 print ""

2400 currentgrade = (earnpointstotal*100)/posspointstotal
2410 minfinalgrade = (earnpointstotal/totalpoints)*100
2420 maxfinalgrade = ((totalpoints - (posspointstotal - earnpointstotal))/totalpoints)*100

2430 print "      Current Grade: "; currentgrade
2440 print "Minimum Final Grade: "; minfinalgrade
2450 print "Maximum Final Grade: "; maxfinalgrade


9998 REM RUN "GradeReport.bas"
9999 END
