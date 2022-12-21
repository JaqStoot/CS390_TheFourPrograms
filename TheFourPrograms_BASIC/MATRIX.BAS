10 REM GET USER INPUT

20 PRINT "=== Please enter your matricies dims. ==="
21 PRINT "Matrix A"
30 INPUT "Row 1"; row1
31 INPUT "Column 1"; col1
32 PRINT "Matrix B"
33 INPUT "Row 2"; row2
34 INPUT "Column 2"; col2

50 IF row1 = col2 THEN GOTO 60
51 PRINT"Invalid Dims"
52 GOTO 21

60 DIM matrixA(row1,col1)
70 DIM matrixB(row2,col2)
80 DIM matrixC(row1,col2)


90 PRINT "=== Enter values into Matrix A. ==="

100 FOR I = 1 TO row1
110 FOR J = 1 TO col1
120 INPUT matrixA(I,J)
121 NEXT J
122 NEXT I

123 PRINT "=== Enter values into Matrix B. ==="
130 FOR I = 1 TO row2
140 FOR J = 1 TO col2
150 INPUT matrixB(I,J)
160 NEXT J
170 NEXT I
179 FOR I = 1 TO row1
180 FOR J = 1 TO col2
190 matrixC(I,J) = 0
200 NEXT J
210 NEXT I


220 FOR I = 1 TO row1
221 FOR J = 1 TO col2
222 FOR K = 1 to row2
230 matrixC(I,J) = matrixC(I,J) + (matrixA(I,K)*(matrixB(K,J)))
240 NEXT K
250 NEXT J
260 NEXT I


270 PRINT "== Matrix A =="
300 FOR I = 1 TO row1
301 PRINT "| ";
310 FOR J = 1 TO col1
320 PRINT matrixA(I,J);
330 NEXT J
340 PRINT " |"
350 NEXT I

360 PRINT " == Matrix B == "
400 FOR I = 1 TO row2
401 PRINT "| ";
410 FOR J = 1 TO col2
420 PRINT matrixB(I,J);
430 NEXT J
440 PRINT " |"
450 NEXT I

460 PRINT " == Matrix C : (A X B) == "
500 FOR I = 1 TO row1
501 PRINT "| ";
510 FOR J = 1 TO col2
520 PRINT matrixC(I,J);
530 NEXT J
540 PRINT "|"
550 NEXT I


