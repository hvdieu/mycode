#include <bits/stdc++.h>

using namespace std;

int main() {
    //freopen("in.txt", "r", stdin);
    int ntest, n;
    cin >> ntest;
    while (ntest--) {
        cin >> n;
        char ch = 'a';
        for(int i = 1; i <= n; i++) {
            cout << ch++;
            if (ch > 'z') ch = 'a';
        }
        cout << "\n";
    }
}
