#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#include <queue>
#include <stack>

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
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 100010

int n, a[N], q, b[N], f[8*N];
char s[N];
int t[8*N][3], dem[3];

void init(int i, int lo, int hi) {
    if (lo == hi) {
        t[i][b[lo]]++;
        return;
    }
    int mid = (lo + hi) / 2;
    init(i*2, lo, mid);
    init(i*2+1, mid+1, hi);
    For(j, 0, 2) t[i][j] = t[i*2][j] + t[i*2+1][j];
}

ll C2(int n) {
    return (ll(n) * (n-1)) / 2;
}

void up(int i, int x) {
    For(cc, 1, x) {
        swap(t[i][2], t[i][1]); swap(t[i][1], t[i][0]);
    }
}

void down(int i) {
    int c1 = i*2, c2 = i*2+1;
    f[i] %= 3; up(i, f[i]);
    f[c1] += f[i];
    f[c2] += f[i];
    f[i] = 0;
}

void update(int i, int lo, int hi, int u, int v, int x) {
    down(i);
    if (lo == u && hi == v) {
        f[i] += x;
        down(i);
        return;
    }
    int mid = (lo + hi) / 2;
    if (u <= mid) update(i*2, lo, mid, u, min(mid, v), x);
    if (v > mid) update(i*2+1, mid+1, hi, max(mid+1, u), v, x);
    down(i*2); down(i*2+1);
    For(j, 0, 2) t[i][j] = t[i*2][j] + t[i*2+1][j];
}

void get(int i, int lo, int hi, int u, int v) {
    down(i);
    if (lo == u && hi == v) {
        For(j, 0, 2) dem[j] += t[i][j];
        return;
    }
    int mid = (lo + hi) / 2;
    if (u <= mid) get(i*2, lo, mid, u, min(mid, v));
    if (v > mid) get(i*2+1, mid+1, hi, max(mid+1, u), v);
    down(i*2); down(i*2+1);
    For(j, 0, 2) t[i][j] = t[i*2+1][j] + t[i*2][j];
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d %d\n", &n, &q);
    scanf("%s\n", s+1);
    For(i, 1, n) {
        a[i] = int(s[i]) - int('0');
        b[i] = (b[i-1] + a[i]) % 3;
    }
    init(1, 0, n);
    while (q) {
        q--;
        int kind, u, v;
        scanf("%d%d%d", &kind, &u, &v);
        if (kind == 1) {
            int change = v - a[u];
            a[u] = v;
            while (change < 0) change += 3;
            change %= 3;
            update(1, 0, n, u, n, change);
            //For(i, u, n) b[i] = (b[i] + change) % 3;
           // reset(dem, 0);
           // For(i, 0, n) dem[b[i]]++;
        } else {
            reset(dem, 0);
            get(1, 0, n, u-1, v);
           // For(i, u-1, v) dem[b[i]]++;
            ll res = C2(dem[0]) + C2(dem[1]) + C2(dem[2]);
            printf("%lld\n", res);
        }
    }
}




