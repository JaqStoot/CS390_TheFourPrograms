c      Start

	   PROGRAM MATRIX
	   INTEGER A, B, C, D, X
	   INTEGER, ALLOCATABLE, DIMENSION (:,:) :: IA
	   INTEGER, ALLOCATABLE, DIMENSION (:,:) :: IB
	   INTEGER, ALLOCATABLE, DIMENSION (:,:) :: IC

	   
1	   PRINT*,'===Entering data for First Matrix==='
	   PRINT*,'--Enter the number of Rows then Columns--'
	   READ(*,*) A, B

	   ALLOCATE(IA(A,B))


	   PRINT*,'===Entering data for Second Matrix==='
	   PRINT*,'--Enter the number of Rows then Columns--'
	   READ(*,*) C, D

	   ALLOCATE(IB(C,D))

	   ALLOCATE(IC(A,D))


	   IF (B.EQ.C) GO TO 10
	   GO TO 111


111	   PRINT*,'Invalid Dimensions'
	   PRINT*
	   PRINT*
	   DEALLOCATE(IA)
	   DEALLOCATE(IB)
	   DEALLOCATE(IC)
c      note: ive found that if we go though this sequence of allocating then deallocating these arrays, the memory addresses that we allocated to the array messes up, so after reallocating, the calculations are incorrect. However, if we enter a correct set of dimensions, the matrix multiplication will be calculated accurately 
       GO TO 1

      
      
      

10	   PRINT*,'Enter Data into First Matrix'
	   DO 20 I=1,A
	   DO 30 J=1,B
	   READ(*, 40) IA(I,J)
40	   FORMAT(I4)
30	   CONTINUE
20        CONTINUE  

	   PRINT*,'Enter Data into Second Matrix'

	   DO 50 I=1,C
	   DO 60 J=1,D
	   READ(*, 70) IB(I,J)
70	   FORMAT(I4)
60	   CONTINUE
50        CONTINUE


	   DO 80 I=1, A
	   DO 90 J=1, D
	   DO 100 K=1, C
	   IC(I,J) = IC(I,J) + (IA(I,K) * IB(K,J))
100	   CONTINUE
90	   CONTINUE
80	   CONTINUE	   

	   DO 110 I=1,A
	   WRITE(*,1001)(IC(I,J),J=1,D)
110	   CONTINUE
1001      FORMAT(1x,7I4)

	   DEALLOCATE(IA)
	   DEALLOCATE(IB)
	   DEALLOCATE(IC)


	   END





