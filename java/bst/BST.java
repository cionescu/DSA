public class BST {
  public static Node root;

  public BST() {
    this.root = null;
  }

  public void insert(int value) {
    Node newNode = new Node(value);
    if (root == null) {
      root = newNode;
      return;
    }
    Node current = root;
    Node parent = null;
    while(true) {
      parent = current;
      if (value < current.data) {
        current = current.left;
        if (current == null) {
          parent.left = newNode;
          return;
        }
      } else {
        current = current.right;
        if (current == null) {
          parent.right = newNode;
          return;
        }
      }
    }
  }

  public boolean find(int value) {
    Node current = root;
    while(current != null) {
      if (current.data == value) {
        return true;
      }

      if(value < current.data) {
        current = current.left;
      } else {
        current = current.right;
      }
    }
    return false;
  }

  public void display(Node root) {
    if (root != null) {
      display(root.left);
      System.out.println(" " + root.data);
      display(root.right);
    }
  }

  public static void main(String[] args) {
    BST tree = new BST();
    tree.insert(3);
    tree.insert(4);
    tree.insert(1);
    tree.display(tree.root);
    System.out.println("Finding 1 " + tree.find(1));
    System.out.println("Finding 2 " + tree.find(2));
  }

}
