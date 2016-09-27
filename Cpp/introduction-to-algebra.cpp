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
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 120

int n, ntest, a[N][N], res, dd[10];

int mag (int i, int j) {
    return a[i][j];
}

int check(int t) {
    int res;
    if (t == 1) {
        For(x, 0, n-1) For(y, 0, n-1) {
            bool ok1 = false, ok2 = false;
            int dem1 = 0, dem2 = 0;
            For(z, 0, n-1) {
                if (mag(x, z) == y) ok1 = true, dem1++;
                if (mag(z, x) == y) ok2 = true, dem2++;
            }
            if (!ok1 || !ok2) return 0;
            if (dem1 > 1 || dem2 > 1) return 0;
        }
        return 1;
    }
    if (t == 2) {
        if (!dd[1]) return 0;
            int dem = 0;
            For(e, 0, n-1) {
                bool flag = true;
                For(x, 0, n-1) if (mag(e, x) != x || mag(x, e) != x) flag = false;
                if (flag) dem++;
            }
            if (!dem || dem > 1) return 0;
        return 2;
    }
    if (t == 3) {
        int dem = 0;
        For(x, 0, n-1) For(y, 0, n-1) For(z, 0, n-1) if (mag(mag(x, y), z) != mag(x, mag(y, z))) return 0;
        return 4;
    }
    if (t == 4) {
        if (!dd[3]) return 0;
        int dem = 0;
            For(e, 0, n-1) {
                bool flag = true;
                For(x, 0, n-1) if (mag(e, x) != x || mag(x, e) != x) flag = false;
                if (flag) dem++;
            }
            if (!dem || dem > 1) return 0;
        return 8;
    }
    if (t == 5) {
        if (!dd[4]) return 0;
        For(x, 0, n-1) For(e, 0, n-1) if (mag(e, x) == x && mag(x, e) == x) {
            bool flag = false;
            For(y, 0, n-1) if (mag(x, y) == e && mag(y, x) == e) flag = true;
            if (!flag) return 0;
        }
        return 16;
    }
    if (t == 6) {
        if (!dd[5]) return 0;
        For(x, 0, n-1) For(y, 0, n-1) if (mag(x, y) != mag(y, x)) return 0;
        return 32;
    }
    if (t == 7) {
        For(x, 0, n-1) For(y, 0, n-1) For(z, 0, n-1) if (mag(x, mag(y, z)) != mag(mag(x, y), mag(x, z))) return 0;
        For(x, 0, n-1) For(y, 0, n-1) {
            bool flag = false; int dem = 0;
            For(z, 0, n-1) if (mag(x, z) == y) flag = true, dem++;
            if (!flag) return 0; if (dem > 1) return 0;
        }
        return 64;
    }
    if (t == 8) {
        if (!dd[7]) return 0;
        For(x, 0, n-1) if (mag(x, x) != x) return 0;
        return 128;
    }
    return 0;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> n; For(i, 0, n-1) For(j, 0, n-1) cin >> a[i][j];
        reset(dd, 0);
        res = 0;
        For(i, 1, 8) {
            dd[i] = check(i); res += dd[i];
        }
        cout << res << endl;
    }
}
