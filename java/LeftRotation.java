/*

* A left rotation operation on an array of size n shifts each of the array's elements 1
* unit to the left. For example, if 2 left rotations are performed on array [1,2,3,4,5],
* then the array would become [3,4,5,1,2].

* Given an array of n integers and a number, d, perform d left rotations on the array.
* Then print the updated array as a single line of space-separated integers.

*/

import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class LeftRotation {

  public static int[] arrayLeftRotation(int[] a, int n, int k) {
    int result[] = new int[n];
    int count = 0;
    while (count < n) {
      if (k < n) {
        result[count] = a[k];
        k += 1;
        count += 1;
      } else {
        k = 0;
        result[count] = a[k];
        count += 1;
        k += 1;
      }
    }
    return result;
  }

  public static void main(String[] args) {
    Scanner in = new Scanner(System.in);
    int n = in.nextInt();
    int k = in.nextInt();
    int a[] = new int[n];
    for(int a_i=0; a_i < n; a_i++){
      a[a_i] = in.nextInt();
    }

    int[] output = new int[n];
    output = arrayLeftRotation(a, n, k);
    for(int i = 0; i < n; i++) {
      System.out.print(output[i] + " ");
    }

    System.out.println();
  }
}
