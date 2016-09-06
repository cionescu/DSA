/*
* Roy wanted to increase his typing speed for programming contests.
* So, his friend advised him to type the sentence "The quick brown fox
* jumps over the lazy dog" repeatedly, because it is a pangram.
* (Pangrams are sentences constructed by using every letter of the
* alphabet at least once.)

* After typing the sentence several times, Roy became bored with it. So
* he started to look for other pangrams.

* Given a sentence s, tell Roy if it is a pangram or not.
*/

import java.io.*;
import java.util.*;

public class Pangram {
  public static void main(String[] args) {
    Scanner in = new Scanner(System.in);
    Set<Character> set = new HashSet<Character>();

    String s = in.nextLine();
    s = s.toLowerCase();

    for (int i = 0; i < s.length(); i++) {
      if (s.charAt(i) != ' ') {
        set.add(s.charAt(i));
      }
    }

   if (set.size() == 26) {
    System.out.println("pangram");
   } else {
    System.out.println("not pangram");
   }
  }
}
