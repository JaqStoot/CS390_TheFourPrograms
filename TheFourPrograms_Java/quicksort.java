import java.util.Arrays;
import java.util.Scanner;

public class quicksort {
    public static void main(String[] args) {
        System.out.println("Enter 10 numbers: ");
        // Create array
        int[] arr = new int[10];
        Scanner input = new Scanner(System.in);
        for (int i = 0; i < 10; i++) {
            arr[i] = input.nextInt();
        }
        quickSort(arr, 0, (arr.length - 1));
        System.out.println("Sorted array: ");
        System.out.println(Arrays.toString(arr));
        input.close();
    }

    static void quickSort(int[] arr, int lowIndex, int highIndex) {
        if (lowIndex >= highIndex) {
            return;
        }
        int pivot = arr[highIndex];
        int leftPointer = lowIndex;
        int rightPointer = highIndex;
        while (leftPointer < rightPointer) {
            while (arr[leftPointer] <= pivot && leftPointer < rightPointer) {
                leftPointer++;
            }
            while (arr[rightPointer] >= pivot && leftPointer < rightPointer) {
                rightPointer--;
            }
            swap(arr, leftPointer, rightPointer);
        }
        swap(arr, leftPointer, highIndex);
        quickSort(arr, lowIndex, leftPointer - 1);
        quickSort(arr, leftPointer + 1, highIndex);
    }

    static void swap(int[] arr, int one, int two) {
        int temp = arr[one];
        arr[one] = arr[two];
        arr[two] = temp;
    }
}
