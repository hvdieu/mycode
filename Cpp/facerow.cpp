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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 5010

int n, t[N], a[N];

void update(int i, int val) {
    while (i <= n) {
        t[i] += val;
        i += i & (-i);
    }
}

int get(int i) {
    int s = 0;
    while (i) {
        s += t[i];
        i -= i & (-i);
    }
    return s;
}

void solve() {
    int res = n+1, bt = n+1;
    For(len, 1, n) {
        reset(t, 0); int dem = 0;
        For(i, 1, n - len + 1) {
            int x = (a[i] + get(i)) % 2;
            if (!x) {
                dem++;
                update(i, 1);
                update(i+len, -1);
            }
        }
        bool flag = true;
        For(i, n - len + 2, n) if ((a[i] + get(i)) % 2 == 0) {
            flag = false; break;
        }
        if (flag && dem < res) {
            res = dem; bt = len;
        }
    }
    if (res == 0) bt = 0;
    cout << bt << ' ' << res;
}

int main() {
    freopen("facerow.inp","r",stdin);
    freopen("facerow.out","w",stdout);
    scanf("%d\n", &n);
    For(i, 1, n) {
        char c; scanf("%c\n", &c);
        if (c == 'B') a[i] = 0;
        else a[i] = 1;
    }
    solve();
}
