C     CREATE ARRAYS
      DIMENSION IList(10) 
      DIMENSION IStack(10)
      iKeep = 1
      DO 10 I=1,10
      WRITE(*,20)I
20    FORMAT('Number ', I4 ':')
      READ(*,30) ILIST(I)
30    FORMAT(I4)
10    CONTINUE
C     GETS ARRAY INPUT
      IStack(1) = 1
      IStack(2) = 10
      iStkPointer = 2
C     Loop 1 I
      DO 40 I=1,1000
      iRightPointer = IStack(iStkPointer)
      iStkPointer = iStkPointer - 1
      iLeftPointer = IStack(iStkPointer)
      iStkPointer = iStkPointer - 1
      iLowIndex = iLeftPointer
      iPivot = iRightPointer
C     Loop 2 J
      DO 50 J=1,1000
C     Loop 3 K
      DO 60 K=1,1000
      IF(IList(iLeftPointer).le.iList(iPivot).and.iLeftPointer.lt.iRight
     1Pointer) GO TO 80
      GO TO 90
100   ikeep = 1
60    CONTINUE
90    iKeep = 1
C     Loop 4 K
      DO 70 K=1,1000
      IF(IList(iRightPointer).ge.iList(iPivot).and.iLeftPointer.lt.iRigh
     1tPointer) GO TO 110
      GO TO 120
130   ikeep = 1
70    CONTINUE
120   iKeep = 1
C     Swapping
      iTemp = iList(iLeftPointer)
      iList(iLeftPointer) = iList(iRightPointer)
      iList(iRightPointer) = iTemp
      if(iLeftPointer.eq.iRightPointer) GO TO 190
50    CONTINUE
190   iKeep = 1
C     Swapping
      iTemp = iList(iLeftPointer)
      iList(iLeftPointer) = iList(iPivot)
      iList(iPivot) = iTemp
C     Temporary Holder for iLeftPointer
      iTempTwo=iLeftPointer+1

      if(iTempTwo.lt.iPivot) GO TO 140

150   iKeep = 1
      if(iLowIndex.lt.iLeftPointer) GO To 160
170   iKeep=1
      iTempThree = 0
      if(iStkPointer.eq.iTempThree) GO TO 180
40    CONTINUE

C     Start of If Statements
80    iLeftPointer = iLeftPointer + 1
      GO TO 100

110   iRightPointer = iRightPointer - 1
      GO TO 130

140   iStkPointer = iStkPointer + 1
      iStack(iStkPointer) = iLeftPointer + 1
      iStkPointer = iStkPointer + 1
      iStack(iStkPointer) = iPivot
      GO TO 150

160   iStkPointer = iStkPointer + 1
      iStack(iStkPointer) = iLowIndex
      iStkPointer = iStkPointer + 1
      iStack(iStkPointer) = iLeftPointer - 1
      GO TO 170

C     End of If statements

180   iKeep = 1
      DO 200 N=1,10
      WRITE(*,210) IList(N)
210   FORMAT(I4)
200   CONTINUE
      END
