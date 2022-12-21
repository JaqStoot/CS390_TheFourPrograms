      * Auto Advisor Program
       IDENTIFICATION DIVISION.
           PROGRAM-ID. AUTOADVISOR.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
           FILE-CONTROL.
           SELECT IFILE ASSIGN TO DYNAMIC FILE-DESC
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD IFILE.
       01 INPUT-FILE.
            05 FILE-DESC PIC X(500).
           
       WORKING-STORAGE SECTION.
           01 DATA-TABLE OCCURS 500 TIMES.
               05 FILE-LINE PIC X(500).
               05 NAME PIC X(50).
               05 HOURS PIC 9(3).
               05 PRE-REQS PIC X(50).
               05 GRADE PIC A(1).
            
           01 NEXT-COURSES OCCURS 50 TIMES.
               05 COURSE-NAME PIC X(50).
               
           01 PRE-REQS-LOGIC OCCURS 10 TIMES.
               05 PRE-REQS-OR OCCURS 10 TIMES.
                   10 PRE-REQ-NAME PIC X(50).
               
           01 COMPLETED-COURSES.
               05 C-COURSE-NAME PIC X(50) OCCURS 50 TIMES INDEXED BY I.
               
           01 UNCOMPLETED-COURSES.
               05 U-COURSE-INDEX PIC 9(3) OCCURS 50 TIMES INDEXED BY J.
               
           01 WS-CAN-TAKE PIC 9(1).
           01 WS-CAN-TAKE-TEMP PIC 9(1).
           
           01 WS-GPA PIC 9(3)V9(2).
           01 WS-FGPA PIC 9(1)V9(2).
           
           01 WS-HOURS-ATTEMPTED PIC 9(3).
           01 WS-FHOURS-ATTEMPTED PIC Z(2)9.
           
           01 WS-HOURS-COMPLETED PIC 9(3).
           01 WS-FHOURS-COMPLETED PIC Z(2)9.
           
           01 WS-HOURS-REMAINING PIC 9(3).
           01 WS-FHOURS-REMAINING PIC Z(2)9.
           
           01 WS-EOF PIC A(1).
           01 WS-INDEX PIC 9(3).
           01 WS-NEXT-INDEX PIC 9(3).
           
           01 WS-TEMP PIC 9(3).
           01 WS-COMMA-CNT PIC 9(3).
           01 WS-COMMA-INDEX PIC 9(3).
           01 WS-SPACE-CNT PIC 9(3).
           01 WS-SPACE-INDEX PIC 9(3).
           
           01 STRFIRST PIC X(50).
           01 STRREST PIC X(50).
           01 STRCNT PIC 99.
           01 STREND PIC 99.
           
           01 WS-ROW PIC 9(3).
           01 WS-COLUMN PIC 9(3).
                      
           01 FILE-NAME PIC X(50).
           
       PROCEDURE DIVISION.
           SET WS-CAN-TAKE TO 0.
           SET WS-GPA TO 0.00.
           SET WS-FGPA TO 0.00.
           SET WS-HOURS-ATTEMPTED TO 0.
           SET WS-HOURS-COMPLETED TO 0.
           SET WS-HOURS-REMAINING TO 0.
           SET WS-INDEX TO 1.
           SET I TO 1.
           SET J TO 1.
           SET WS-NEXT-INDEX TO 1.
           SET WS-COMMA-CNT TO 0.
           SET WS-SPACE-CNT TO 0.
           SET WS-ROW TO 1.
           SET WS-COLUMN TO 1.
           
      * Get user input
           DISPLAY "Filename: " WITH NO ADVANCING.
           ACCEPT FILE-NAME.
           MOVE FILE-NAME TO FILE-DESC.
                      
           OPEN INPUT IFILE.
           
      * Read data from file into variables
           PERFORM READ-COURSES UNTIL WS-EOF = 'Y'.
           DONE-READ.
           CLOSE IFILE.
           
      * Handle pre-reqs
           SET J TO 1.
           PERFORM PRE-REQ-SECTION UNTIL J = WS-INDEX.
           
      * Display results
           PERFORM DISPLAY-RESULTS.
           
           STOP RUN.
           
       READ-COURSES.
           READ IFILE INTO FILE-LINE(WS-INDEX)
               AT END MOVE "Y" TO WS-EOF
           END-READ
           
           IF WS-EOF = 'Y' GO TO DONE-READ.
           
           UNSTRING FUNCTION TRIM(FILE-LINE(WS-INDEX))
                 DELIMITED BY '|'
                 INTO  NAME(WS-INDEX)
                       HOURS(WS-INDEX)
                       PRE-REQS(WS-INDEX)
                       GRADE(WS-INDEX)
           END-UNSTRING.
           
      * Put classes into correct lists
           IF GRADE(WS-INDEX) = "A" THEN
               ADD HOURS(WS-INDEX) TO WS-HOURS-ATTEMPTED
               ADD HOURS(WS-INDEX) TO WS-HOURS-COMPLETED
               COMPUTE WS-GPA = (HOURS(WS-INDEX) * 4.0) + WS-GPA
               MOVE NAME(WS-INDEX) TO C-COURSE-NAME(I)
               ADD 1 TO I
           END-IF.
           IF GRADE(WS-INDEX) = "B" THEN
               ADD HOURS(WS-INDEX) TO WS-HOURS-ATTEMPTED
               ADD HOURS(WS-INDEX) TO WS-HOURS-COMPLETED
               COMPUTE WS-GPA = (HOURS(WS-INDEX) * 3.0) + WS-GPA
               MOVE NAME(WS-INDEX) TO C-COURSE-NAME(I)
               ADD 1 TO I
           END-IF.
           IF GRADE(WS-INDEX) = "C" THEN
               ADD HOURS(WS-INDEX) TO WS-HOURS-ATTEMPTED
               ADD HOURS(WS-INDEX) TO WS-HOURS-COMPLETED
               COMPUTE WS-GPA = HOURS(WS-INDEX) * 2.0 + WS-GPA
               MOVE NAME(WS-INDEX) TO C-COURSE-NAME(I)
               ADD 1 TO I
           END-IF.
           IF GRADE(WS-INDEX) = "D" THEN
               ADD HOURS(WS-INDEX) TO WS-HOURS-ATTEMPTED
               ADD HOURS(WS-INDEX) TO WS-HOURS-COMPLETED
               COMPUTE WS-GPA = HOURS(WS-INDEX) * 1.0 + WS-GPA
               MOVE NAME(WS-INDEX) TO C-COURSE-NAME(I)
               ADD 1 TO I
           END-IF.
           IF GRADE(WS-INDEX) = "F" THEN
               ADD HOURS(WS-INDEX) TO WS-HOURS-ATTEMPTED
               ADD HOURS(WS-INDEX) TO WS-HOURS-REMAINING
               MOVE WS-INDEX TO U-COURSE-INDEX(J)
               ADD 1 TO J
           END-IF.
           IF GRADE(WS-INDEX) = " " THEN
               ADD HOURS(WS-INDEX) TO WS-HOURS-REMAINING
               MOVE WS-INDEX TO U-COURSE-INDEX(J)
               ADD 1 TO J
           END-IF.
                                
           ADD 1 TO WS-INDEX.
           
       PRE-REQ-SECTION.
      * Split classes by spaces then by commas and apply logic
           SET WS-TEMP TO J.
           SET WS-CAN-TAKE TO 0.
           SET WS-COMMA-CNT TO 0.
           SET WS-SPACE-CNT TO 0.
           SET WS-COMMA-INDEX TO 1.
           SET STRCNT TO 0.
           
           SET WS-COLUMN TO 1.
           
           IF PRE-REQS(U-COURSE-INDEX(J)) <> " " THEN
               PERFORM PRE-REQ-LOGIC
           ELSE
               SET WS-CAN-TAKE TO 1
           END-IF.
           
           IF WS-CAN-TAKE = 1 THEN
               SET J TO WS-TEMP
               MOVE NAME(U-COURSE-INDEX(J)) TO
               NEXT-COURSES(WS-NEXT-INDEX)
               ADD 1 TO WS-NEXT-INDEX
           END-IF.
           SET J TO WS-TEMP.
           ADD 1 TO J.
           
       PRE-REQ-LOGIC.
           PERFORM CONTAIN-SPACE.
           PERFORM SPLIT-PRE-REQS-OR WS-SPACE-CNT TIMES.
               
           SET WS-COLUMN TO 1.
           ADD 1 TO WS-SPACE-CNT.
           PERFORM PRE-REQ-AND-LOOP UNTIL WS-COLUMN = WS-SPACE-CNT
           OR WS-CAN-TAKE = 1.
               
           SET WS-CAN-TAKE TO WS-CAN-TAKE-TEMP.
           
       PRE-REQ-AND-LOOP.
           SET WS-ROW TO 1.
           SET WS-COMMA-CNT TO 0.
           SET WS-COMMA-INDEX TO 1.
           SET WS-CAN-TAKE TO 1.
           SET WS-CAN-TAKE-TEMP TO WS-CAN-TAKE.
           SET WS-CAN-TAKE TO 0.
           
           PERFORM CONTAIN-COMMA.
           PERFORM SPLIT-PRE-REQS-AND WS-COMMA-CNT TIMES.
           ADD 2 TO WS-COMMA-CNT.
           
           PERFORM SEARCH-PRE-REQS UNTIL WS-ROW = WS-COMMA-CNT
           OR WS-CAN-TAKE-TEMP = 0.
                      
           IF WS-CAN-TAKE-TEMP = 1 THEN SET WS-CAN-TAKE TO 1.
           
           ADD 1 TO WS-COLUMN.
           
           
       SEARCH-PRE-REQS.
           SET I TO 1.
           SEARCH C-COURSE-NAME
               AT END PERFORM NOT-FOUND
               WHEN C-COURSE-NAME(I) = PRE-REQ-NAME(WS-COLUMN, WS-ROW)
                   MOVE " " TO PRE-REQ-NAME(WS-COLUMN, WS-ROW)
                   SET WS-CAN-TAKE-TEMP TO 1
                   ADD 1 TO WS-ROW
                   
           END-SEARCH.
       
       NOT-FOUND.
           MOVE " " TO PRE-REQ-NAME(WS-COLUMN, WS-ROW)
           SET WS-CAN-TAKE-TEMP TO 0.
           SET WS-ROW TO 1.
           
       CONTAIN-COMMA.
           INSPECT PRE-REQ-NAME(WS-COLUMN, WS-ROW)
           TALLYING WS-COMMA-CNT FOR ALL ",".
           
       CONTAIN-SPACE.
           INSPECT FUNCTION TRIM(PRE-REQS(U-COURSE-INDEX(J)))
           TALLYING WS-SPACE-CNT FOR ALL " ".
           ADD 1 TO WS-SPACE-CNT.
           IF FUNCTION TRIM(PRE-REQS(U-COURSE-INDEX(J)))=
               "Senior Standing" THEN
               SUBTRACT 1 FROM WS-SPACE-CNT
           END-IF.
           
       SPLIT-PRE-REQS-AND.
           UNSTRING FUNCTION
           TRIM(PRE-REQ-NAME(WS-COLUMN, WS-COMMA-INDEX))
           DELIMITED BY ','
           INTO STRFIRST
           COUNT IN STRCNT.
           COMPUTE STRCNT = STRCNT + 2.
           COMPUTE STREND = 50 - STRCNT + 1.
           MOVE PRE-REQ-NAME(WS-COLUMN, WS-COMMA-INDEX)(STRCNT:STREND)
           TO STRREST.
           MOVE STRFIRST TO PRE-REQ-NAME(WS-COLUMN, WS-COMMA-INDEX).
           ADD 1 TO WS-COMMA-INDEX.
           MOVE STRREST to PRE-REQ-NAME(WS-COLUMN, WS-COMMA-INDEX).
           
           
       SPLIT-PRE-REQS-OR.
           IF FUNCTION TRIM(PRE-REQS(U-COURSE-INDEX(J)))
           ="Senior Standing" THEN
               MOVE "Senior Standing" TO PRE-REQ-NAME(WS-COLUMN, 1)
           ELSE
               UNSTRING FUNCTION TRIM(PRE-REQS(U-COURSE-INDEX(J)))
               DELIMITED BY ' '
               INTO STRFIRST
               COUNT IN STRCNT
               COMPUTE STRCNT = STRCNT + 2
               COMPUTE STREND = 50 - STRCNT + 1
               MOVE PRE-REQS(U-COURSE-INDEX(J))(STRCNT:STREND)
               TO STRREST
               MOVE STRFIRST TO PRE-REQ-NAME(WS-COLUMN, 1)
               MOVE STRREST to PRE-REQS(U-COURSE-INDEX(J))
           END-IF.
           ADD 1 TO WS-COLUMN.
           
           
       DISPLAY-RESULTS.
           COMPUTE WS-GPA ROUNDED = WS-GPA / WS-HOURS-ATTEMPTED.
           
           MOVE WS-GPA TO WS-FGPA.
           MOVE WS-HOURS-ATTEMPTED TO WS-FHOURS-ATTEMPTED.
           MOVE WS-HOURS-COMPLETED TO WS-FHOURS-COMPLETED.
           MOVE WS-HOURS-REMAINING TO WS-FHOURS-REMAINING.
           
           DISPLAY "GPA: " WS-FGPA.
           DISPLAY "Hours Attempted: " WS-FHOURS-ATTEMPTED.
           DISPLAY "Hours Completed: " WS-FHOURS-COMPLETED.
           DISPLAY "Hours Remaining: " WS-FHOURS-REMAINING.
           DISPLAY " ".
           DISPLAY "Possible Courses to Take Next".
           
           IF WS-HOURS-REMAINING = 0 THEN
               DISPLAY "None - Congratulations!"
           ELSE
               SET WS-INDEX TO 1
               PERFORM LIST-NEXT UNTIL WS-INDEX EQUAL TO WS-NEXT-INDEX
           END-IF.
           
       LIST-NEXT.
           IF NEXT-COURSES(WS-INDEX) <> " " THEN
           DISPLAY NEXT-COURSES(WS-INDEX)
           END-IF.
           ADD 1 TO WS-INDEX.
