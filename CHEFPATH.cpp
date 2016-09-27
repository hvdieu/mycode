#include <bits/stdc++.h>

using namespace std;

long long m, n;
int ntest;

int main() {
    cin >> ntest;
    while (ntest-- > 0) {
        cin >> m >> n;
        if (m > n) swap(m, n);
        bool flag = false;
        if (m == 1 && n == 1) flag = true;
        if ((m % 2 == 0 || n % 2 == 0) && m != 1) flag = true;
        if (flag) cout << "Yes\n"; else cout << "No\n";
    }
}
