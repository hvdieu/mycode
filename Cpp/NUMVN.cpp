#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))

ll X, A, B, res, a[12], f[12][100000][2][2], n;
bool dd[10], check[12][100000][2][2];

bool kt(ll X) {
    while (X) {
        int ch = X % 10;
        if (!dd[ch]) return false;
        X /= 10;
    }
    return true;
}

void sub1() {
    res = 0;
    for (int i = 1; ; i++) if (X * i > B) break;
    else if (X * i >= A && kt(X * i)) res++;
    cout << res;
}

void convert(ll x) {
    n = 0;
    while (x) {
        a[++n] = x % 10;
        x /= 10;
    }
}

ll cal(int i, int du, int ok1, int ok2) {
    if (!i) {
        if (du == 0 && ok2) return 1;
        return 0;
    }
    if (check[i][du][ok1][ok2]) return f[i][du][ok1][ok2];
    ll res = 0;
    int c, t1, t2;
    if (ok1) c = 9; else c = a[i];
    For(j, 0, c) if (dd[j]) {
        if (ok1 || j < a[i]) t1 = 1; else t1 = 0;
        if (ok2 || j) t2 = 1; else t2 = 0;
        res += cal(i - 1, (du * 10 + j) % X, t1, t2);
    }
    check[i][du][ok1][ok2] = true;
    f[i][du][ok1][ok2] = res;
    return res;
}

void sub2() {
    convert(B);
    res = cal(n,0,0,0);
    convert(A - 1);
    reset(check, false);
    res = res - cal(n,0,0,0);
    cout << res;
}

int main() {
    freopen("numvn.inp","r",stdin);
    freopen("numvn.out","w",stdout);
    cin >> X >> A >> B;
    string s;
    cin >> s;
    For(i, 0, sz(s)-1) dd[s[i] - '0'] = true;
    if (X > 100000) sub1();
    else sub2();
}


