#include <vector>
#include <fstream>
#include <iostream>


class Set {
  private:
    std::vector<int> set;
    bool present(int value);

  public:
    Set();
    ~Set();
    void print();
    void push(int value);
};
