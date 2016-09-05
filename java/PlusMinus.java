/*

* Given an array of integers, calculate which fraction of its elements are
* positive, which fraction of its elements are negative, and which fraction
* of its elements are zeroes, respectively. Print the decimal value of each
* fraction on a new line.

*/

import java.io.*;
import java.util.*;

public class PlusMinus {
  public static void main(String[] args) {
    Scanner in = new Scanner(System.in);
    int num = in.nextInt();
    int positives = 0;
    int negatives = 0;
    int zeroes = 0;

    for(int i = 0; i < num; i++) {
      int temp = in.nextInt();

      if (temp == 0) {
        zeroes += 1;
      } else if (temp < 0) {
        negatives += 1;
      } else {
        positives += 1;
      }
    }

    System.out.printf("%.6f\n%.6f\n%.6f\n", positives / (double)num, negatives / (double)num, zeroes / (double)num);
  }
}
