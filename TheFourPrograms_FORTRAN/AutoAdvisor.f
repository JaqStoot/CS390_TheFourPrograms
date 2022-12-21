c     This program is an auto advisor
c     Variables
c     ======================================
      CHARACTER input(50,37)
      DATA input/'C','S','1','0','1','|','3','|','|','A', 40*'.',
     &'C','S','1','5','5','|','4','|','C','S','1','0','1','|','A',
     &35*'.',
     &'C','S','2','4','5','|','3','|','C','S','1','0','1','|','B',
     &35*'.',
     &'C','S','2','6','5','|','4','|','C','S','1','5','5','|',
     &36*'.',
     &'C','S','2','8','8','|','4','|','C','S','2','4','5','|',
     &36*'.',
     &'C','S','3','0','0','|','3','|','C','S','2','6','5','|',
     &36*'.',
     &'C','S','3','4','5','|','3','|','C','S','2','4','5','|',
     &36*'.',
     &'C','S','3','5','0','|','3','|','C','S','3','0','0',',','C',
     &'S','3','4','5','|', 30*'.',
     &'C','S','3','5','1','|','4','|','C','S','1','5','5','|',
     &36*'.',
     &'C','S','3','8','0','|','3','|','C','S','2','8','8',',','C',
     &'S','3','5','1','|', 30*'.',
     &'C','S','3','9','0','|','3','|','C','S','3','0','0','|',
     &36*'.',
     &'C','S','4','3','3','|','3','|','C','S','3','0','0','|',
     &36*'.',
     &'C','S','4','4','0','|','3','|','C','S','2','6','5','|',
     &36*'.',
     &'C','S','4','4','5','|','3','|','S','e','n','i','o','r',' ',
     &'S','t','a','n','d','i','n','g','|',26*'.',
     &'C','S','4','8','0','|','3','|','C','S','3','5','1','|',
     &36*'.',
     &'C','S','4','9','5','|','1','|','C','S','4','4','5','|',
     &36*'.',
     &'C','S','4','9','9','|','3','|','C','S','4','4','5','|',
     &36*'.',
     &'C','S','5','9','1','|','3','|','C','S','3','0','0',',','C',
     &'S','3','8','0',',','C','S','4','8','0',' ','C','S','3','0',
     &'0','C','S','5','0','3',' ','C','S','5','0','0',',','C','S',
     &'5','0','3','|', '',
     &'C','Y','2','0','1','|','4','|','C','S','1','5','5','|',
     &36*'.',
     &'I','U','3','1','5','|','3','|','|','A',40*'.',
     &'M','A','1','3','9','|','3','|','A','C','T','2','4',' ','M',
     &'A','1','1','6',' ','M','A','1','3','7','|','A',23*'.',
     &'M','A','2','2','3','|','3','|','A','C','T','2','4',' ','M',
     &'A','1','1','6','|',30*'.',
     &'M','A','4','6','4','|','3','|','M','A','2','2','3',' ','M',
     &'A','2','5','0',' ','M','A','3','3','8',' ','M','A','3','4',
     &'5',' ','M','A','4','4','3','|',12*'.',
     &'C','S','3','x','x','+','|','6','|','|',40*'.',
     &'S','c','i','e','n','c','e','|','9','|','|',39*'.',
     &'S','o','c','i','a','l',' ','a','n','d',' ','B','e','h','a',
     &'v','i','o','r','a','l',' ','S','c','i','e','n','c','e','s',
     &'|','6','|','|',16*'.',
     &'P','S','1','0','3','|','3','|','|','B',40*'.',
     &'W','r','i','t','t','e','n',' ','C','o','m','m','u','n','i',
     &'c','a','t','i','o','n','|','3','|','|',25*'.',
     &'E','N','1','0','0','|','3','|','|','B',40*'.',
     &'S','P','1','0','4','|','3','|','|','B',40*'.',
     &'N','a','t','u','r','a','l',' ','S','c','i','e','n','c','e',
     &'s','|','7','|','|',30*'.',
     &'H','u','m','a','n','i','t','i','e','s',' ','a','n','d',' ',
     &'F','i','n','e',' ','A','r','t','s','|','6','|','|',22*'.',
     &'A','R','1','0','4','|','3','|','|','C',40*'.',
     &'A','d','d','i','t','i','o','n','a','l',' ','R','e','q','u',
     &'i','r','e','m','e','n','t','s','|','2','|','|',23*'.',
     &'U','I','1','0','0','|','3','|','|','A',40*'.',
     &'S','e','n','i','o','r',' ','S','t','a','n','d','i','n','g',
     &'|','0','|','|',31*'.',
     &'A','C','T','2','4','|','0','|','|',41*'.'/

      CHARACTER nextCourses(50,37)
      CHARACTER courseName(50)
      CHARACTER completedCourses(50,37)
      CHARACTER preReqs(50,37)
      CHARACTER preReq(50)

      REAL GPA
      INTEGER attempted
      INTEGER completed
      INTEGER remaining

      INTEGER completedIndex
      INTEGER uncompletedIndex

      INTEGER index
      INTEGER credits
      CHARACTER grade

      INTEGER gradeChecked
      INTEGER nextCourseIndex
      INTEGER completedCoursesIndex
      INTEGER preReqsIndex
      INTEGER preReqsIndexY
      INTEGER noPreReq

c     Formatters
c     ======================================
100   FORMAT()
200   FORMAT(I4)
300   FORMAT("GPA: ", F4.2)
310   FORMAT("Attempted: ", I3)
320   FORMAT("Completed: ", I3)
330   FORMAT("Remaining: ", I3)
340   FORMAT("Possible courses to take next:")
350   FORMAT(50A)
360   FORMAT(1A)
 
c     Read through Data
c     ======================================
      GPA = 0.0
      completed = 0
      attempted = 0
      remaining = 0
      nextCourseIndex = 0
      completedCoursesIndex = 0
      preReqsIndex = 1
      preReqsIndexY = 0
      noPreReq = 0

c     Loop through each column in data
      DO 1000 I=1,37
      credits = 0
      index = 0
      gradeChecked = 0
      noPreReq = 0
      preReqsIndex = 1

      DO 1001 K=1, 50
      courseName(K) = ''
      preReq(K) = ''
1001  CONTINUE

c     Loop through each row entry in column
      DO 1100 J=1,50
      IF (input(J,I) .EQ. '|') index = index + 1


c     Read course name
      IF (index .NE. 0) GOTO 1110
      courseName(J) = input(J,I)

c     Read credit hours
1110  IF (index .NE. 1) GOTO 1210
      READ (input(J,I), *, iostat=ios) credits

c     Check if pre-reqs
1210  IF (index .NE. 2) GOTO 1310
      IF (input(J,I) .NE. '|' .OR. input(J+1,I) .NE. '|') GOTO 1220
      noPreReq = 1

1220  IF (input(J,I) .EQ. '|') GOTO 1310
      preReq(preReqsIndex) = input(J,I)
      preReqsIndex = preReqsIndex + 1

c     Read grade
1310  IF (index .NE. 3) GOTO 1100
      READ (input(J,I), *, iostat=ios) grade

      IF (gradeChecked .EQ. 1) GOTO 1100

      IF (grade .NE. 'A') GOTO 1320
      GPA = GPA + FLOAT(4 * credits)
      attempted = attempted + credits
      completed = completed + credits
      gradeChecked = 1

      DO 1311 K=1, 50
      completedCourses(K,completedCoursesIndex) = courseName(K)
1311  CONTINUE

1320  IF (grade .NE. 'B') GOTO 1330
      GPA = GPA + FLOAT(3 * credits)
      attempted = attempted + credits
      completed = completed + credits
      gradeChecked = 1

      DO 1321 K=1, 50
      completedCourses(K,completedCoursesIndex) = courseName(K)
1321  CONTINUE

1330  IF (grade .NE. 'C') GOTO 1340
      GPA = GPA + FLOAT(2 * credits)
      attempted = attempted + credits
      completed = completed + credits
      gradeChecked = 1

      DO 1331 K=1, 50
      completedCourses(K,completedCoursesIndex) = courseName(K)
1331  CONTINUE

1340  IF (grade .NE. 'D') GOTO 1350
      GPA = GPA + FLOAT(credits)
      attempted = attempted + credits
      completed = completed + credits
      gradeChecked = 1

      DO 1341 K=1, 50
      completedCourses(K,completedCoursesIndex) = courseName(K)
1341  CONTINUE

1350  IF (grade .NE. 'F') GOTO 1360
      attempted = attempted + credits
      remaining = remaining + credits
      gradeChecked = 1

1360  IF (grade .NE. '.') GOTO 1370
      remaining = remaining + credits
      gradeChecked = 1

c     IF no pre-req and no grade add to next Course list
      DO 1373 K=1, 50
      IF (preReq(K) .NE. '') GOTO 1373
      preReq(K) = ' '
1373  CONTINUE
      
1370  IF (grade .NE. '.' .OR. noPreReq .NE. 1) GOTO 1380
      nextCourseIndex = nextCourseIndex + 1
      DO 1371 K=1, 50
      nextCourses(K,nextCourseIndex) = courseName(K)
1371  CONTINUE

      GOTO 1100
1380  IF(grade .NE. '.') GOTO 1100
      

1100  CONTINUE

1000  CONTINUE

c     Set GPA
      GPA = GPA / attempted

      WRITE(*, 300) GPA
      WRITE(*, 310) attempted
      WRITE(*, 320) completed
      WRITE(*, 330) remaining
      WRITE(*, 340)

c     Print next course list
      nextCourseIndex = nextCourseIndex + 1
      DO 2000 I=1,100
      IF (nextCourseIndex .EQ. 38) GOTO 3000
      DO 2100, L=1, 50
      nextCourses(L, nextCourseIndex) = ' '
    
2100  CONTINUE
      nextCourseIndex = nextCourseIndex + 1
2000  CONTINUE

3000  PRINT 350, nextCourses


      END
