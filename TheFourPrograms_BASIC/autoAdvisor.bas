10 DIM courses$(100)
11 DIM credits(100)
12 DIM preqs$(100)
13 DIM grades$(100)
14 DIM completedCourses$(100)
15 completedIndex = 1
16 DIM nextC$(100)
17 nextIndex = 1
18 GPA = 1.00
19 attempted = 0
20 completed = 0
21 remaining = 0
22 start = 0
23 logicand = 0
24 logicor = 0


100 INPUT "FILE: "; F$
110 OPEN F$ FOR INPUT AS #1

120 FOR I=1 TO 100
121 LINE INPUT #1, l$

131 FOR J=1 TO 100
132 if MID$(l$,J,1) <> "|" THEN GOTO 136
133 courses$(I) = MID$(l$,1,J-1)
134 start = J
135 J = 100
136 NEXT J

140 FOR J=start+1 TO 100
141 IF MID$(l$,J,1) <> "|" THEN GOTO 145
142 credits(I) = VAL(MID$(l$,start+1,J-start-1))
143 start = J
144 J = 100
145 NEXT J

150 FOR J=start+1 TO 100
151 IF MID$(l$,J,1) <> "|" THEN GOTO 155
152 preqs$(I) = MID$(l$,start+1,J-start-1)
153 start = J
154 J = 100

155 NEXT J
160 IF MID$(l$,start+1,1) = "" THEN GOTO 163
161 grades$(I) = MID$(l$,start+1,1)
162 GOTO 170
163 grades$(I) = "U"

170 NEXT I

180 FOR I=1 TO 100
190 IF grades$(I) <> "A" THEN GOTO 200
191 completedCourses$(completedIndex) = courses$(I)
192 completedIndex = completedIndex + 1
193 GPA = GPA + (4 * credits(I))
194 attempted = attempted + credits(I)
195 completed = completed + credits(I)

200 IF grades$(I) <> "B" THEN GOTO 210
201 completedCourses$(completedIndex) = courses$(I)
202 completedIndex = completedIndex + 1
203 GPA = GPA + (3 * credits(I))
204 attempted = attempted + credits(I)
205 completed = completed + credits(I)

210 IF grades$(I) <> "C" THEN GOTO 220
211 completedCourses$(completedIndex) = courses$(I)
212 completedIndex = completedIndex + 1
213 GPA = GPA + (2 * credits(I))
214 attempted = attempted + credits(I)
215 completed = completed + credits(I)

220 IF grades$(I) <> "D" THEN GOTO 230
221 completedCourses$(completedIndex) = courses$(I)
222 completedIndex = completedIndex + 1
223 GPA = GPA + credits(I)
224 attempted = attempted + credits(I)
225 completed = completed + credits(I)

230 IF grades$(I) <> "F" THEN GOTO 240
231 attempted = attempted + credits(I)
240 NEXT I

250 FOR I=1 TO 100
251 logicor = 0
252 logicand = 0
260 IF grades$(I) = "U" THEN GOTO 290
270 IF grades$(I) = "F" THEN GOTO 290
280 GOTO 400
290 remaining = remaining + credits(I)
291 IF preqs$(I) = "" THEN nextC$(I) = courses$(I)
292 FOR J=1 TO 100
300 IF MID$(preqs$(I),J,1) = "," THEN logicand = -1
310 IF MID$(preqs$(I),J,1) <> " " THEN GOTO 340
320 IF preqs$(I) <> "Senior Standing" THEN logicor = -1
340 NEXT J
360 FOR J=1 TO 100
370 IF preqs$(I) = completedCourses$(J) THEN nextC$(I) = courses$(I)
380 NEXT J
390 IF logicand + logicor = 0 THEN GOTO 400
391 IF logicor = -1 THEN GOTO 395
392 GOSUB 1000
393 IF logicand = -1 THEN nextC$(I) = courses$(I)
394 GOTO 400
395 GOSUB 2000
396 IF logicor = -1 THEN nextC$(I) = courses$(I)
400 NEXT I
401 GOTO 3000

1000 REM LOGICAND
1010 logicand = -1
1020 courseName$ = ""
1030 FOR J=1 TO 100
1035 IF MID$(preqs$(I),J,1) = "" THEN GOTO 1060
1040 IF MID$(preqs$(I),J,1) <> "," THEN courseName$ = courseName$ + MID$(preqs$(I),J,1)
1050 IF MID$(preqs$(I),J,1) <> "," THEN GOTO 1110
1060 FOR K=1 TO 100
1070 IF courseName$ = completedCourses$(K) THEN GOTO 1090
1075 IF completedCourses$(K) <> "" THEN GOTO 1080
1076 logicand = 0
1077 GOTO 1120
1080 NEXT K
1090 IF K = 100 THEN logicand = 0
1100 IF logicand = 0 THEN GOTO 1120
1105 courseName$ = ""
1106 IF MID$(preqs$(I),J+1,1) = "" THEN GOTO 1120
1110 NEXT J
1120 RETURN

2000 REM LOGICOR
2010 logicor = 0
2020 sectionor$ = ""
2030 preqstemp$ = preqs$(I)
2035 FOR L=1 TO 100
2040 IF MID$(preqs$(I),L,1) = "" THEN GOTO 2065
2050 IF MID$(preqs$(I),L,1) <> " " THEN sectionor$ = sectionor$ + MID$(preqs$(I),L,1)
2060 IF MID$(preqs$(I),L,1) <> " " THEN GOTO 2110
2065 IF sectionor$ = "" THEN GOTO 2120
2070 preqs$(I) = sectionor$
2080 GOSUB 1000
2090 preqs$(I) = preqstemp$
2095 sectionor$ = ""
2100 IF logicand = -1 THEN logicor = -1
2105 IF logicand = -1 THEN GOTO 2120
2110 NEXT L
2120 RETURN


3000 PRINT "FILE: "; F$
3001 GPA = GPA / attempted
3009 PRINT "GPA: ";
3010 IF GPA <> 0 THEN PRINT USING "##.##"; GPA, 
3011 IF GPA = 0 THEN PRINT "0",
3020 PRINT "Hours Attempted: "; attempted
3030 PRINT "Hours Completed: "; completed
3040 PRINT "Credits Remaining: "; remaining
3045 PRINT " ",
3050 PRINT "Possible Courses to Take Next",
3060 IF remaining = 0 THEN PRINT "None - Congratulations!",
3070 FOR I=1 TO 100
3080 IF nextC$(I) <> "" THEN PRINT nextC$(I)
3090 NEXT I
9999 END
