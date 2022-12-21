      * Grade Report program for 'The Four Programs' in COBOL 
      * Written by John Stout, Jacob Hall, Jacob Thieret,
      * Justin Kehoe, and Noah Little 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GradeReport.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FILENAME ASSIGN TO FSTRING
           ORGANIZATION IS LINE SEQUENTIAL.
       
       DATA DIVISION.
       FILE SECTION.
       FD FILENAME.
       01 FILENAME-FILE.
           05 Category PIC A(20).
           05 Asg_Name PIC A(20).
           05 Points_Earned PIC 9(14).
           05 Points_Possible PIC 9(14).

       WORKING-STORAGE SECTION.
      * Initialize variables to process file with
       01 CURRENT_POINTS PIC 9(14).
       01 TOTAL_POINTS PIC 9(14).
       01 POINTS_A PIC 9(14).
       01 POINTS_R PIC 9(14).
       01 CURRENT_GRADE PIC 9(14).
       01 MAX_GRADE PIC 9(14).
       01 MIN_GRADE PIC 9(14).
       01 CAT_TOTAL PIC 9(14).
       01 CAT_CURRENT PIC 9(14).
       01 CWEIGHT PIC 9(14).
       01 TNUM PIC Z(14)9.
       01 TNUM2 PIC Z(14)9.
       01 TNUM3 PIC Z(14)9.

       01 FSTRING PIC A(20).
       01 TSTRING PIC A(20) VALUE ' '. 
       01 ESTRING PIC A(20) VALUE ' '.
      * Create filearray to store values in
       01 FARRAY.
           05 tableRow OCCURS 10 TIMES. 
              10 asgName PIC X(20).
              10 cat PIC X(20).
              10 pP PIC 9(14).
              10 pE PIC 9(14).
       01 EOF PIC A(1). 

       01 Counter PIC 9(10).
       01 Counter2 PIC 9(10).

       PROCEDURE DIVISION.
      * Fills array with some data
           SET Counter TO 1.

           DISPLAY 'File: '.
           ACCEPT FSTRING.
           OPEN INPUT FILENAME.

           READ FILENAME NEXT RECORD INTO TOTAL_POINTS 

           PERFORM UNTIL EOF='Y'
                READ FILENAME INTO TableRow(Counter)
                   AT END MOVE 'Y' TO EOF
                END-READ
                ADD 1 TO Counter
                
           END-PERFORM.
           CLOSE FILENAME.

      * Here's some boring math for you, calculating point values
           
           SET Counter TO 1.
           SET CURRENT_POINTS TO 0.
           PERFORM UNTIL Counter=10
              ADD FUNCTION NUMVAL(pE(Counter)) TO CURRENT_POINTS
              ADD 1 TO Counter
           END-PERFORM.

           SET Counter TO 1.
           SET POINTS_A TO 0.
           PERFORM UNTIL Counter=10
              ADD FUNCTION NUMVAL(pP(Counter))TO POINTS_A
              ADD 1 TO Counter
           END-PERFORM.

           SET POINTS_R TO 0.
           COMPUTE POINTS_R = TOTAL_POINTS - POINTS_A

           SET CURRENT_GRADE TO 0.
           COMPUTE CURRENT_GRADE = CURRENT_GRADE * 100 / POINTS_A

           SET MAX_GRADE TO 0.
           COMPUTE MAX_GRADE = (POINTS_R + CURRENT_POINTS)*100
           COMPUTE MAX_GRADE = MAX_GRADE / TOTAL_POINTS  

           SET MIN_GRADE TO 0.
           COMPUTE MIN_GRADE = ((CURRENT_POINTS * 100) / TOTAL_POINTS)

      * Output is formatted and printed, with some error 
      * (problems lining things up)
           DISPLAY " "
           SET Counter to 1.
           PERFORM UNTIL Counter = 10
           IF cat(Counter) IS NOT EQUAL " " THEN
              COMPUTE CWEIGHT = FUNCTION NUMVAL(pE(Counter))* 100
              COMPUTE CWEIGHT = CWEIGHT / FUNCTION NUMVAL(pP(Counter))
              MOVE CWEIGHT to TNUM 
              DISPLAY cat(Counter) FUNCTION TRIM(TNUM) "%" 
              DISPLAY "================================="

              MOVE pE(Counter) to TNUM
              MOVE pP(Counter) to TNUM2
              MOVE CWEIGHT to TNUM3
              DISPLAY asgName(Counter) FUNCTION TRIM(TNUM)"/" 
              FUNCTION TRIM(TNUM2) "    " FUNCTION TRIM(TNUM3) "%"
              DISPLAY "================================="

              DISPLAY "                      " FUNCTION TRIM(TNUM)"/" 
              FUNCTION TRIM(TNUM2) "    " FUNCTION TRIM(TNUM3) "%"
              DISPLAY " "
              SET CWEIGHT to 0

           END-IF
           ADD 1 TO Counter
           END-PERFORM

           MOVE CURRENT_GRADE TO TNUM
           DISPLAY "Current Grade: " FUNCTION TRIM(TNUM)  "%"
           MOVE MIN_GRADE TO TNUM
           DISPLAY "Minimum Final Grade: " FUNCTION TRIM(TNUM)"%"
           MOVE MAX_GRADE TO TNUM
           DISPLAY "Maximum Final Grade: " FUNCTION TRIM(TNUM)"%"

           STOP RUN.
