#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)

const int N = 1e5 + 10;

int n, ntest, a[N], l[N], r[N];

int main() {
    //freopen("in.txt", "r", stdin);
    cin >> ntest;
    while (ntest--) {
        cin >> n;
        For(i, 1, n) cin >> a[i];
        int i = 1;
        bool flag = false;
        while (i <= n) {
            int j = i;
            while (j < n && a[i] == a[j+1]) j++;
            if (j - i >= 2) flag = true;
            i = j + 1;
        }
        if (flag) cout << "Yes\n"; else cout << "No\n";
    }
}
