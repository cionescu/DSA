## Braille converter in CPP

*Background*

> This was inspired by the coding challenge for last year's AngelHack [http://angelhack.com/solve-these-developer-challenges-to-snag-free-tickets-to-our-series/](http://angelhack.com/solve-these-developer-challenges-to-snag-free-tickets-to-our-series/). My plan is to implement it using a binary trie. Other implementations may include using a Hash Table, but for a fixed size alphabet `(2 rows * 3 columns)`, I believe the binary trie would be have the right balance between space complexity `O(n)` having 36 nodes, and search time of `O(logn)` having the height of 6.

*Implementation*

Say the alphabet is described by a 1 * 2 matrix. If we want to encode the matrix, we will store it as a binary array. (0, 0), (0, 1), (1, 0), (1, 1) are the mappings of A, B, C, D for this small alphabet. A binary trie would look like:

```
      root
    0       1
  0   1   0   1
  A   B   C   D
```
