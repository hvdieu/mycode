#include <bits/stdc++.h>

using namespace std;

int main() {
    char a = 'a';
    char* p1 = &a;
    cout << *p1;
    int* p2 = (int*)p1;
    *p2 = 'b';
    cout << *p2;
}
