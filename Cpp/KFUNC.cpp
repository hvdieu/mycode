#include <bits/stdc++.h>

using namespace std;

const int N = 100;

long long a, d, l, r, len, res;
int f[N + 10], ntest;

int sum_digits(long long x) {
    int res = 0;
    while (x) {
        res += x % 10;
        x /= 10;
    }
    return res;
}

int g(long long x) {
    if (x < 10) return x;
    return g(sum_digits(x));
}

void check(long long a, long long d, long long l, long long r) {
    a += (l - 1) * d;
    long long res = 0;
    for(l; l <= r; l++) {
        res += g(a);
        a += d;
    }
    cout << res << endl;
}

int main() {
    ios_base::sync_with_stdio(false);
   // freopen("input.txt", "r", stdin);
   // freopen("output.txt", "w", stdout);
    cin >> ntest;
    for(int i = 0; i <= N; i++)
        if (i < 10) f[i] = i;
        else f[i] = f[sum_digits(i)];
    f[0] = f[90];
    while (ntest) {
        ntest--;
        cin >> a >> d >> l >> r;
        //check(a, d, l, r);
        d %= 90;
        a += (l-1) * d;
        a %= 90;
        len = (r - l + 1);
        res = 0;
        long long aa = a;
        int i = 1;
        for(i = 1; i <= len; i++) {
            res += f[aa];
            aa = (aa + d) % 90;
            if (aa == a) break;
        }
       // cout << i << ' ' << len << endl;
       // cout << res << endl;
        if (i < len) {
            res = res + ((len - i) / i) * res;
            aa = a;
            for(int j = 1; j <= (len - i) % i; j++) {
                res += f[aa];
                aa = (aa + d) % 90;
            }
        }
        cout << res << endl;
    }
}
