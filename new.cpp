#include <bits/stdc++.h>

using namespace std;

int n;
string s;

int main() {
    char s[6] = {'H', 'e', 'l', 'l', 'o', '\0'};
    cout << (int*) &s << "\n";
    cout << int(s + 0) << "\n";
    cout << s << "\n";
    cout << int(s) << "\n";
}
