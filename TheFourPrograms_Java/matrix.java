import java.util.Scanner;

public class matrix {

    public static void main(String[] args) {
        System.out.println("Matrix A");
        System.out.println("========");
        int aRows;    //intialize row int for matrix A
        int aColumns; //intialize column int for matrix A
        Scanner input = new Scanner(System.in);
        System.out.print("Rows: ");
        aRows = input.nextInt();
        System.out.print("Cols: ");
        aColumns = input.nextInt();
        float aMatrix[][] = new float[aRows][aColumns]; //declare a matrix using row and column size variables
        System.out.println("Values: ");
        for (int i = 0; i < aRows; i++) {
            for (int j = 0; j < aColumns; j++) {
                aMatrix[i][j] = input.nextFloat();  //taking values for a matrix according to size
            }
        }

        System.out.println("");
        System.out.println("Matrix B");
        System.out.println("========");
        int bRows;      //intialize row int for matrix B
        int bColumns;   //intialize column int for matrix B
        System.out.print("Rows: ");
        bRows = input.nextInt();
        System.out.print("Cols: ");
        bColumns = input.nextInt();
        float bMatrix[][] = new float[bRows][bColumns];  //declare b matrix using row and column size variables
        System.out.println("Values: ");
        for (int p = 0; p < bRows; p++) {
            for (int q = 0; q < bColumns; q++) {
                bMatrix[p][q] = input.nextFloat(); //taking values for b matrix according to size
            }
        }
        if (aColumns != bRows)     //check if dimensions are compatible
        {
            System.out.println("Incompatible Dimensions");
        } else  //as long as dimensions are correct
        {
            float resultMatrix[][] = new float[aRows][bColumns]; //declaring result matrix
            for (int z = 0; z < aRows; z++) {
                for (int r = 0; r < bColumns; r++) {
                    for (int t = 0; t < bRows; t++) {
                        resultMatrix[z][r] = resultMatrix[z][r] + aMatrix[z][t] * bMatrix[t][r];
                    }
                }
            }

            System.out.println("A x B = ");
            //print pretty formatted matrix :)
            for (int k = 0; k < aColumns; k++) {
                for (int o = 0; o < bColumns; o++)
                    System.out.print(resultMatrix[k][o] + "\t");

                System.out.print("\n");
            }
        }


    }
}
