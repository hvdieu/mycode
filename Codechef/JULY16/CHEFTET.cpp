#include <bits/stdc++.h>

using namespace std;

const int N = 1e4 + 5;

int n, a[N], b[N], ntest;
long long sum, c[N];

long long solve() {
    if (sum % n) return -1;
    long long aver = sum / n;
    for(int i = 1; i <= n; i++) {
        c[i] = aver - a[i];
        if (c[i] < 0) return -1;
    }

    for(int i = 1; i <= n; i++) {
        if (c[i] < 0) return -1;
        if (!c[i] && i < n) {
            c[i+1] -= b[i];
            b[i] = 0;
        } else {
            if (c[i] == b[i]) c[i] = b[i] = 0;
            else if (i < n && c[i] == b[i+1]) {
                c[i] = b[i+1] = 0;
                if (i < n) {
                    c[i+1] -= b[i]; b[i] = 0;
                }
            } else if (i < n && c[i] == b[i] + b[i+1]) {
                b[i] = b[i+1] = c[i] = 0;
            }
        }
    }
    for(int i = 1; i <= n; i++)
        if (c[i] || b[i]) return -1;
    return aver;
}

int main() {
    //ifstream cin("in.txt");
    cin >> ntest;
    while (ntest--) {
        cin >> n;
        sum = 0;
        for(int i = 1; i <= n; i++) cin >> b[i], sum += b[i];
        for(int i = 1; i <= n; i++) cin >> a[i], sum += a[i];
        cout << solve() << "\n";
    }
}
