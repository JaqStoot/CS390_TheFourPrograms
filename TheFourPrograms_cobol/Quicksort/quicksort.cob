      *Quicksort
       IDENTIFICATION DIVISION.
           PROGRAM-ID. QUICKSORT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-LOWINDEX       PIC 9(3).
       01 WS-HIGHINDEX      PIC 9(3).
       01 WS-STKPOINTER     PIC 9(3).
       01 WS-LEFTPOINTER    PIC 9(3).
       01 WS-RIGHTPOINTER   PIC 9(3).
       01 WS-PIVOT          PIC 9(3).
       01 WS-I              PIC 9(3).
       01 WS-J              PIC 9(3).
       01 WS-TEMP           PIC 9(3).
       01 WS-LEFTPOINTERP   PIC 9(3).
       01 WS-LOWINDEXP      PIC 9(3).
       01 WS-LEFTPOINTERM   PIC 9(3).
       01 WS-STACK.
           05 WS-B PIC 9(3) VALUE 0 OCCURS 10 TIMES.
       01 WS-ARRAY.
           05 WS-A PIC 9(3) VALUE 0 OCCURS 10 TIMES.


       PROCEDURE DIVISION.
           DISPLAY "Enter 10 Numbers:".
           PERFORM READ-N VARYING WS-I FROM 1 BY 1 UNTIL WS-I GREATER 10
      -    .
           SET WS-LOWINDEX TO 1.
           SET WS-HIGHINDEX TO 10.
           SET WS-B(1) TO WS-LOWINDEX.
           SET WS-B(2) TO WS-HIGHINDEX.
           SET WS-STKPOINTER TO 2.
           PERFORM F-SORT UNTIL WS-STKPOINTER EQUAL 0.
           DISPLAY "Sorted table: ".
           PERFORM PRIN-R VARYING WS-I FROM 1 BY 1 UNTIL WS-I GREATER 10
      -    .
           
       STOP RUN.

       READ-N.
           ACCEPT WS-A(WS-I).

       F-SORT.
           SET WS-RIGHTPOINTER TO WS-B(WS-STKPOINTER).
           SET WS-STKPOINTER DOWN BY 1.
           SET WS-LEFTPOINTER TO WS-B(WS-STKPOINTER).
           SET WS-STKPOINTER DOWN BY 1
           SET WS-LOWINDEX TO WS-LEFTPOINTER.
           SET WS-PIVOT TO WS-RIGHTPOINTER.
           PERFORM F-PIVOT UNTIL WS-LEFTPOINTER = WS-RIGHTPOINTER.
           SET WS-TEMP TO WS-A(WS-LEFTPOINTER).
           SET WS-A(WS-LEFTPOINTER) TO WS-A(WS-PIVOT).
           SET WS-A(WS-PIVOT) TO WS-TEMP.
           SET WS-LEFTPOINTERP TO WS-LEFTPOINTER.
           SET WS-LOWINDEXP TO WS-LOWINDEX.
           ADD 1 TO WS-LEFTPOINTERP.
           ADD 1 TO WS-LOWINDEXP.
           IF WS-LEFTPOINTERP < WS-PIVOT THEN
               PERFORM F-FIRST
           END-IF.
           IF WS-LOWINDEXP < WS-LEFTPOINTER THEN
               PERFORM F-SECOND
           END-IF.

       F-PIVOT.
           PERFORM LEFT-MOVE UNTIL WS-A(WS-LEFTPOINTER)
      -    > WS-A(WS-PIVOT) OR  WS-LEFTPOINTER >= WS-RIGHTPOINTER.
           PERFORM RIGHT-MOVE UNTIL WS-A(WS-RIGHTPOINTER) <
      -    WS-A(WS-PIVOT) OR WS-LEFTPOINTER >=  WS-RIGHTPOINTER.
           SET WS-TEMP TO WS-A(WS-LEFTPOINTER).
           SET WS-A(WS-LEFTPOINTER) TO WS-A(WS-RIGHTPOINTER).
           SET WS-A(WS-RIGHTPOINTER) TO WS-TEMP.


       LEFT-MOVE.
           ADD 1 TO WS-LEFTPOINTER.

       RIGHT-MOVE.
           SET WS-RIGHTPOINTER DOWN BY 1.

       F-FIRST.
           ADD 1 TO WS-STKPOINTER.
           SET WS-B(WS-STKPOINTER) TO WS-LEFTPOINTERP.
           ADD 1 TO WS-STKPOINTER.
           SET WS-B(WS-STKPOINTER) TO WS-PIVOT.

       F-SECOND.
           ADD 1 TO WS-STKPOINTER.
           SET WS-B(WS-STKPOINTER) TO WS-LOWINDEX.
           ADD 1 TO WS-STKPOINTER.
           SET WS-LEFTPOINTERM TO WS-LEFTPOINTER.
           SET WS-LEFTPOINTERM DOWN BY 1.
           SET WS-B(WS-STKPOINTER) TO WS-LEFTPOINTERM.

       PRIN-R.
           DISPLAY WS-A(WS-I).
