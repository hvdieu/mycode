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
#define N 50001

int t[8*N], n, q, m, a[N], f[N];

void down(int i, int lo, int hi) {
    int mid = (lo + hi) / 2;
    if (f[i] > 0) {
        if (f[i]) {
            t[i*2] = (mid - lo + 1);
            t[i*2+1] = hi - mid;
        } else t[i*2] = t[i*2+1] = 0;
        f[i*2] = f[i*2+1] = f[i];
    	f[i] = -1;
    }
}

void update(int i, int lo, int hi, int u, int v, int val) {
	if (u > v) return;
    if (lo == u && hi == v) {
        if (val) t[i] = (hi - lo + 1);
        else t[i] = 0;
        f[i] = val;
        return;
    }
    int mid = (lo + hi) / 2;
    down(i, lo, hi);
    if (u <= mid) update(i*2, lo, mid, u, min(mid, v), val);
    if (v > mid) update(i*2+1, mid+1, hi, max(u, mid+1), v, val);
    t[i] = t[i*2] + t[i*2+1];
}

void solve() {
    int nn = 0;
    reset(f, 0xff);
    For(i, 1, m) {
        update(1, 1, n-1, nn+1, nn + a[i] - 1, 1);
        nn += a[i];
    }
    while (q) {
        char c;
        q--;
        cin >> c;
        if (c == 'C') cout << n-t[1] << endl;
        else {
            int u, v, val; cin >> u >> v;
            v--;
            if (c == 'J') val = 1; else val = 0;
            update(1, 1, n-1, u, v, val);
        }
    }
}

int main() {
    freopen("ws.inp","r",stdin);
  //  freopen("ws.out","w",stdout);
    scanf("%d %d", &m, &q);
    For(i, 1, m) {
        scanf("%d", &a[i]);
        n += a[i];
    }
    solve();
}
