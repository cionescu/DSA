#include <iostream>
#include <fstream>
#include "Set.h"

int main() {
  Set set;

  set.push(1);
  set.push(2);
  set.push(3);
  set.push(2);
  set.push(3);
  set.print();

  return 0;
}
