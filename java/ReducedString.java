/*

* Shil has a string, S, consisting of N lowercase English letters.
* In one operation, he can delete any pair of adjacent letters with same
* value. For example, string "aabcc" would become either "aab" or "bcc"
* after 1 operation.

* Shil wants to reduce  as much as possible. To do this, he will repeat the
* above operation as many times as it can be performed. Help Shil out by
* finding and printing S's non-reducible form!

* Note: If the final string is empty, print Empty String.
*/

import java.io.*;
import java.util.*;

public class ReducedString {
  public static void main(String[] args) {
    Scanner in = new Scanner(System.in);
    String input = in.next();
    Stack stack = new Stack();

    for (int i = 0; i < input.length(); i++) {
      if (!stack.empty() && (char)stack.peek() == input.charAt(i)) {
        stack.pop();
      } else {
        stack.push(input.charAt(i));
      }
    }

    if (stack.empty()) {
      System.out.println("Empty String");
    } else {
      String result = "";
      while(!stack.empty()) {
        result += stack.pop();
      }
      String reversed = new StringBuilder(result).reverse().toString();
      System.out.println(reversed);
    }
  }
}
