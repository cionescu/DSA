/*
* On her 7th birthday, Sandy's uncle, Richie Rich, offered her an n-digit
* check which she refused because the number was not a palindrome. Richie
* then challenged Sandy to make the number palindromic by changing no more
* than k digits. Sandy can only change  digit at a time, and cannot add
* digits to (or remove digits from) the number.

* Given k and an n-digit number, help Sandy determine the largest possible
* number she can make by changing  digits.

* Note: Treat the integers as numeric strings. Leading zeros are permitted
* and can't be ignored (So 0011 is not a palindrome, 0110 is a valid
* palindrome). A digit can be modified more than once.

6 3 092282
*/

import java.io.*;
import java.util.*;

public class Palindrome {
  public static boolean misalignment(StringBuilder number, int i, int n) {
    if (number.charAt(i) != number.charAt(n-i-1)) {
      return true;
    }
    return false;
  }

  public static String palindromify(int n, int permittedChanges, StringBuilder number) {
    int numberChanges = 0;
    int misalignedDigits = 0;

    for (int i = 0; i < n / 2; i++) {
      if (misalignment(number, i, n)) {
        misalignedDigits += 1;
      }
    }

    if (misalignedDigits > permittedChanges) {
      // IMPOSSIBLE
      return "-1";
    } else {
      if (n == 1) {
         if (permittedChanges > 0) {
          return "9";
        } else {
          return number.toString();
        }
      }

      for (int i = 0; i < n / 2; i++) {
        if (misalignment(number, i, n)) {
          if (misalignedDigits < (permittedChanges - numberChanges)) {
            number.setCharAt(i, '9');
            number.setCharAt(n-i-1, '9');
            numberChanges += 2;
          } else {
            int first = Integer.parseInt(number.charAt(i) + "");
            int second = Integer.parseInt(number.charAt(n-i-1) + "");
            if (first > second) {
              number.setCharAt(n-i-1, number.charAt(i));
              numberChanges += 1;
            } else {
              number.setCharAt(i, number.charAt(n-i-1));
              numberChanges += 1;
            }
          }
        }
      }

      for (int i = 0; i < n / 2; i++) {
        String temp = number.charAt(i) + "";
        int remainingChanges = permittedChanges - numberChanges;
        if ( remainingChanges >= 2 && !temp.equals("9")) {
          number.setCharAt(i, '9');
          number.setCharAt(n-i-1, '9');
          numberChanges += 2;
        }
      }

      if (n % 2 == 1 && (permittedChanges - numberChanges) > 0 ) {
        number.setCharAt(n / 2, '9');
      }

     return number.toString();
    }
  }

  public static void main(String[] args) {
    assert palindromify(4, 1, new StringBuilder("0011")).equals("-1") : "4,1,0011 should be -1";
    assert palindromify(1, 1, new StringBuilder("5")).equals("9") : "1,1,5 should be 9" ;
    assert palindromify(6, 2, new StringBuilder("932239")).equals("992299") : "6,2,932239 should be 992299";
    assert palindromify(4, 4, new StringBuilder("3943")).equals("9999") : "4,4,3943 should be 9999";
    assert palindromify(5, 4, new StringBuilder("11331")).equals("99399") : "5,4,11331 should be 99399";
    assert palindromify(5, 1, new StringBuilder("99199")).equals("99999") : "5,1,99199 should be 99999";

    Scanner in = new Scanner(System.in);
    int n = in.nextInt();
    int permittedChanges = in.nextInt();
    StringBuilder number = new StringBuilder(in.next());

    System.out.println(palindromify(n, permittedChanges, number));
  }
}
