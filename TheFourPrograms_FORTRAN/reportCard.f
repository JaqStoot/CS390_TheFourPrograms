c     Report Card Fortran Program
      CHARACTER(len=20), DIMENSION (6) :: ArrAssignName
      CHARACTER(len=20), DIMENSION (6) :: ArrCategory
      INTEGER, DIMENSION (6) :: ArrPossPoints
      INTEGER, DIMENSION (6) ::  ArrEarnPoints
      
      INTEGER Pcnt

      INTEGER PossPointsTotal
      INTEGER EarnPointsTotal

      INTEGER GroupProjectTotal
      INTEGER HomeworkTotal
      INTEGER ProgTotal
      INTEGER QuizzesTotal

      INTEGER GroupProjectEarn
      INTEGER HomeworkEarn
      INTEGER ProgEarn
      INTEGER QuizzesEarn
 
      INTEGER CurrentGrade
      INTEGER MinFinalGrade
      INTEGER MaxFinalGrade
C     ----------------------------


C     Input Loop

      DO 100 I=1,6

      WRITE(*,15)
15    FORMAT('Enter Assignment Name: ')
      READ(*,20) ArrAssignName(I)
20    FORMAT(A20)


      WRITE(*,25)
25    FORMAT('Enter Category: ')
      READ(*,30) ArrCategory(I)
30    FORMAT(A20)

      WRITE(*,35)
35    FORMAT('Enter Points Possible: ')
      READ(*,40) ArrPossPoints(I)
40    FORMAT(I14)

      WRITE(*,45)
45    FORMAT('Enter Points Earned: ')
      READ(*,46) ArrEarnPoints(I)
46    FORMAT(I14)
      
      PossPointsTotal = PossPointsTotal + ArrPossPoints(i)
      EarnPointsTotal = EarnPointsTotal + ArrEarnPoints(i)

      IF(ArrCategory(i).EQ.'Group Project') GOTO 47
      GOTO 48
47    GroupProjectTotal = GroupProjectTotal + ArrPossPoints(i)
      GroupProjectEarn = GroupProjectEarn + ArrEarnPoints(i)
      
      GO TO 100
48    IF(ArrCategory(i).EQ.'Programming') GOTO 49
      GOTO 50
49    ProgTotal = ProgTotal + ArrPossPoints(i)
      ProgEarn = ProgEarn + ArrEarnPoints(i)

      GOTO 100
50    IF(ArrCategory(i).EQ.'Quizzes') GOTO 51
      GOTO 52
51    QuizzesTotal = QuizzesTotal + ArrPossPoints(i)
      QuizzesEarn = QuizzesEarn + ArrEarnPoints(i)
      
      GOTO 100
52    IF(ArrCategory(i).EQ.'Homework') GOTO 53
      GOTO 100
53    HomeworkTotal = HomeworkTotal + ArrPossPoints(i)
      HomeworkEarn = HomeworkEarn + ArrEarnPoints(i)

100   CONTINUE


C     OUTPUT SECTION

C     GROUP PROJECT OUTPUT
      WRITE(*,55)
55    FORMAT('GROUP PROJECT')
      WRITE(*,99)
99    FORMAT('======================================')

      DO 200 I=1,6
      
      IF(ArrCategory(i).EQ.'Group Project') GOTO 59
      GOTO 200
59    Pcnt = (ArrEarnPoints(i)*100)/ArrPossPoints(i)
      EarnPointsTemp = EarnedPointsTemp + ArrEarnPoints(i)

60    WRITE(*,65)ArrAssignName(i),ArrEarnPoints(i),ArrPossPoints(i),Pcnt
65    FORMAT(A20''I5'/'I2'   'I3'%')


200   CONTINUE
      WRITE(*,99)
      Pcnt = (GroupProjectEarn*100)/GroupProjectTotal
      WRITE(*,66) '',GroupProjectEarn,GroupProjectTotal,Pcnt
66    FORMAT(A20''I5'/'I2'   'I3'%')
        

C     HOMEWORK OUTPUT
      WRITE(*,70)
70    FORMAT('HOMEWORK')
      WRITE(*,99)
      
      DO 300 I=1,6

      IF(ArrCategory(i).EQ.'Homework') GOTO 74
      GOTO 300
74    Pcnt = (ArrEarnPoints(i)*100)/ArrPossPoints(i)
      

75    WRITE(*,80)ArrAssignName(i),ArrEarnPoints(i),ArrPossPoints(i),Pcnt
80    FORMAT(A20''I5'/'I2'   'I3'%')

300   CONTINUE
      WRITE(*,99)
      Pcnt = (HomeworkEarn*100)/HomeworkTotal
      WRITE(*,81) '',HomeworkEarn,HomeworkTotal,Pcnt
81    FORMAT(A20''I5'/'I2'   'I3'%')


C     PROGRAMMING OUTPUT
      WRITE(*,85)
85    FORMAT('PROGRAMMING')
      WRITE(*,99)

      DO 400 I=1,6

      IF(ArrCategory(i).EQ.'Programming') GOTO 89
      GOTO 400

89    Pcnt = (ArrEarnPoints(i)*100)/ArrPossPoints(i)

90    WRITE(*,95)ArrAssignName(i),ArrEarnPoints(i),ArrPossPoints(i),Pcnt
95    FORMAT(A20''I5'/'I2'   'I3'%')

400   CONTINUE
      WRITE(*,99)
      Pcnt = (ProgEarn*100)/ProgTotal
      WRITE(*,96) '',ProgEarn,ProgTotal,Pcnt
96    FORMAT(A20''I5'/'I2'   'I3'%')


C     QUIZZES OUTPUT
      WRITE(*,105)
105   FORMAT('QUIZZES')
      WRITE(*,99)

      DO 500 I=1,6

      IF(ArrCategory(i).EQ.'Quizzes') GOTO 109
      GOTO 500

109   Pcnt = (ArrEarnPoints(i)*100)/ArrPossPoints(i)

110   WRITE(*,5)ArrAssignName(i),ArrEarnPoints(i),ArrPossPoints(i),Pcnt

C     Named 5 to shorten line 110
5     FORMAT(A20''I5'/'I2'   'I3'%')

500   CONTINUE
      WRITE(*,99)
      Pcnt = (QuizzesEarn*100)/QuizzesTotal
      WRITE(*,116) '',QuizzesEarn,QuizzesTotal,Pcnt
116   FORMAT(A20''I5'/'I2'   'I3'%')
      

      CurrentGrade = (EarnPointsTotal*100)
      CurrentGrade = CurrentGrade/PossPointsTotal
      MinimumFinalGrade = (EarnPointsTotal)/1000
      MaximumFinalGrade = (1000 - (PossPointsTotal - EarnPointsTotal))/100

      WRITE(*,115)CurrentGrade
115   FORMAT('Current Grade: 'I3'%')
      WRITE(*,120)MinFinalGrade
120   FORMAT('Minimum Final Grade: 'I3'%')
      WRITE(*,125)MaxFinalGrade
125   FORMAT('Maximum Final Grade: 'I3'%')
      



      END
