/*
* Given an integer, n, perform the following conditional actions:

* If n is odd, print Weird
* If n is even and in the inclusive range of 2 to 5, print Not Weird
* If n is even and in the inclusive range of 6 to 20, print Weird
* If n is even and greater than 20, print Not Weird
**/

import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class RegexTest {
  public static void main(String[] args) {
    Scanner scan = new Scanner(System.in);
    String input = scan.next();

    Pattern first = Pattern.compile("2|3|4|5");
    Pattern second = Pattern.compile("6|7|8|9|10|11|12|13|14|15|16|17|18|19|20");

    if (Integer.parseInt(input) % 2 == 1) {
      System.out.println("Weird");
    } else if(Integer.parseInt(input) > 20) {
      System.out.println("Not Weird");
    } else {
      if (second.matcher(input).find()) {
        System.out.println("Weird");
      } else if (first.matcher(input).find()) {
        System.out.println("Not Weird");
      }
    }
  }
}
