#include <stdio.h>
#include <algorithm>
#include <iostream>
#define NULL 0
int main() {
  srand(time(NULL));
  freopen("input.txt", "w", stdout);
  int n = 5000;
  cout << n << '\n';
  int q = 50000;
  cout << q << '\n';
  while (q--) {
    int u = random(1, n);
    int v = random(1, n);
//    if (u == v) {
//      ++q;
//      continue;
//    }
    int k = random(1, 3);
    cout << k << ' ' << u << ' ' << v << '\n';
  }
}
