        IDENTIFICATION DIVISION.
            PROGRAM-ID. MAT-MUL.
        
        ENVIRONMENT DIVISION.
        
        DATA DIVISION.
        WORKING-STORAGE SECTION.
            01  MAT1.
                02  MR1  OCCURS 5 TIMES.
                     03  MC1  PIC 9(2)  OCCURS 5 TIMES.
            01  MAT2.
                02  MR2  OCCURS 5 TIMES.
                     03  MC2  PIC 9(2)  OCCURS 5 TIMES.
            01  MAT3.
                02  MR3  OCCURS 5 TIMES.
                     03  MC3  PIC 9(3)  OCCURS 5 TIMES.

            01  ROW1  PIC  9.
            01  ROW2  PIC  9.
            01  COL1  PIC  9.
            01  COL2  PIC  9.
            01  I  PIC  9.
            01  J  PIC  9.
            01  K  PIC  9.
            

        PROCEDURE DIVISION.
        START-MATRIX.
            DISPLAY " ".
            DISPLAY "Enter the number of rows for matrix 1".
            ACCEPT ROW1.
            DISPLAY " ".
            DISPLAY "Enter the number of columns for matrix 1".
            ACCEPT COL1.
            DISPLAY " ".
            DISPLAY "Enter the number of rows for matrix 2".
            ACCEPT ROW2.
            DISPLAY " ".
            DISPLAY "Enter the number of columns for matrix 2".
            ACCEPT COL2.
            DISPLAY " ".
            IF (ROW1 IS NOT EQUAL TO COL2)
                DISPLAY "Please enter valid dimensions!"
            ELSE
                PERFORM MATRIX-MULT.
            DISPLAY " ".
            DISPLAY " ".
            STOP RUN.

        MATRIX-MULT.
            DISPLAY " ".
            DISPLAY " ".
            DISPLAY "Enter numbers for first matrix"
            
       
            PERFORM ACCEPT-MAT1 VARYING I FROM 1 BY 1 UNTIL I > ROW1
                AFTER J FROM 1 BY 1 UNTIL J > COL1

            DISPLAY "Enter numbers for second matrix"
            PERFORM ACCEPT-MAT2 VARYING I FROM 1 BY 1 UNTIL I > ROW2
                AFTER J FROM 1 BY 1 UNTIL J > COL2

            PERFORM INIT-MAT3 VARYING I FROM 1 BY 1 UNTIL I > ROW1
                AFTER J FROM 1 BY 1 UNTIL J > COL2

            PERFORM CALC-MAT3 VARYING I FROM 1 BY 1 UNTIL I > ROW1
                AFTER J FROM 1 BY 1 UNTIL J > COL2
                    AFTER K FROM 1 BY 1 UNTIL K > COL1.

            
            
            DISPLAY " ".
            DISPLAY "First Matrix: ".
            DISPLAY " ".

            PERFORM PRINT-MAT1 VARYING I FROM 1 BY 1 UNTIL I > ROW1
                AFTER J FROM 1 BY 1 UNTIL J > COL1.

            DISPLAY " ".
            DISPLAY "Second Matrix:".
            DISPLAY " ".

            PERFORM PRINT-MAT2 VARYING I FROM 1 BY 1 UNTIL I > ROW2
                AFTER J FROM 1 BY 1 UNTIL J > COL2.

            DISPLAY " ".
            DISPLAY "Result: ".
            DISPLAY " ".

            PERFORM PRINT-MAT3 VARYING I FROM 1 BY 1 UNTIL I > ROW1
                AFTER J FROM 1 BY 1 UNTIL J > COL2.
            DISPLAY " ".
        
        ACCEPT-MAT1.
            ACCEPT MC1(I J).
        
        ACCEPT-MAT2.
            ACCEPT MC2(I J).

        INIT-MAT3.
            COMPUTE MC3(I J) = 0.

        CALC-MAT3.
            COMPUTE MC3(I J)  =  MC3(I J) + MC1(I K)  *  MC2(K J).
        
        PRINT-MAT1.
            DISPLAY MC3(I J).
        
        PRINT-MAT2.
            DISPLAY MC1(I J).
        
        PRINT-MAT3.
            DISPLAY MC2(I J).
        
        

            