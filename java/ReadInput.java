import java.util.*;

public class ReadInput {
  public static void main(String[] args) {
    Scanner scan = new Scanner(System.in);
    int intInput = scan.nextInt();
    String stringInput = scan.next();
    scan.nextLine();
    String lineInput = scan.nextLine();
    scan.close();

    System.out.println("The integer is " + intInput);
    System.out.println("The string is " + stringInput);
    System.out.println("The line is " + lineInput);
  }
}
