import java.util.*;

public class RunningMedian {
  public static void insert(ArrayList<Integer> numbers, int value) {
    if (numbers.size() == 0) {
      numbers.add(value);
      return;
    } else if (value < numbers.get(0)) {
      numbers.add(0, value);
      return;
    } else if (value > numbers.get(numbers.size() - 1)) {
      numbers.add(value);
      return;
    }
    for (int i = 0; i < numbers.size(); i++) {
      if (numbers.get(i) < value && value < numbers.get(i+1)) {
        numbers.add(i + 1, value);
        return;
      }
    }
  }

  public static double runningMedian(ArrayList<Integer> numbers) {
    int size = numbers.size();

    if (size % 2 == 0) {
      return (numbers.get(size / 2 - 1) + numbers.get(size / 2)) / 2.0;
    } else {
      return numbers.get(size / 2);
    }
  }

  public static void main(String[] args) {
    Scanner in = new Scanner(System.in);
    int n = in.nextInt();
    ArrayList<Integer> numbers = new ArrayList<Integer>();

    for (int i = 0; i < n; i++) {
      insert(numbers, in.nextInt());
      System.out.println(runningMedian(numbers));
    }
  }
}
