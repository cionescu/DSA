import java.util.*;
public class HashMapTest {
  public static void main(String[] args) {
    HashMap<Integer, String> map = new HashMap<Integer, String>();
    for(int i = 0; i < 10; i++) {
      map.put(i, i + " blah");
    }
    for(Map.Entry<Integer, String> entry : map.entrySet()) {
      System.out.println(entry.getKey() + " = " + entry.getValue());
    }
  }
}
