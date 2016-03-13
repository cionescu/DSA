#include "Set.h"

Set::Set(void) {
}

Set::~Set(void) {
}

void Set::print() {
  int count = this->set.size();
  for (int i = 0; i < count; ++i) {
    std::cout<<this->set.at(i)<<" ";
  }
  std::cout<<std::endl;
}

void Set::push(int value) {
  if (!this->present(value)) {
    this->set.push_back(value);
  }
}

bool Set::present(int value) {
  int count = this->set.size();
  for (int i = 0; i < count; ++i) {
    if (this->set.at(i) == value) {
      return true;
    }
  }
  return false;
}
