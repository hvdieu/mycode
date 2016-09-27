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
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 100010

struct query {
    int id, l, r;
};

int P, Q, n, h[N], mu[N], a[N], p, dem[N];
char s[N];
ll kq[N], res;
query b[N];
ii c[N];

bool cmp(query a, query b) {
    if (a.l / p != b.l / p) return a.l / p < b.l / p;
    return a.r < b.r;
}

void init() {
    sort(c+1, c+n+1);
    c[0].fi = 0;
    a[0] = 1;
    int cnt = 1;
    For(i, 1, n) {
        if (c[i].fi != c[i-1].fi) cnt++;
        a[c[i].se] = cnt;
    }

    p = trunc(sqrt(n));
    sort(b+1, b+1+Q, cmp);
}

void push(int x) {
    res += dem[x] * 2;
    dem[x]++;
}

void pop(int x) {
	dem[x]--;
    res -= dem[x] * 2;

}

void solve() {
    init();
    b[0].l = -1000000;
    For(i, 1, Q) {
        if (b[i].l / p != b[i-1].l / p) {
            reset(dem, 0); res = 0;
            For(j, b[i].l, b[i].r) push(a[j]);
        } else {
            For(j, b[i-1].r+1, b[i].r) push(a[j]);
            if (b[i-1].l < b[i].l) For(j, b[i-1].l, b[i].l-1) pop(a[j]);
            else For(j, b[i].l, b[i-1].l-1) push(a[j]);
        }
        kq[b[i].id] = res;
    }
    For(i, 1, Q) printf("%lld\n", kq[i] / 2);
}

int main() {
    freopen("input.txt", "r", stdin);
   // freopen("output.txt","w", stdout);
    scanf("%d%d\n", &P, &Q);
    scanf("%s\n", s+1);
    n = strlen(s+1);
    mu[0] = 1;
    For(i, 1, n) mu[i] = (ll(mu[i-1]) * 10) % P;
    Rep(i, n, 1) {
        h[i] = (ll(h[i+1]) + mu[n-i+1] * (int(s[i]) - int('0'))) % P;
        c[i] = ii(h[i], i);
    }
    For(i, 1, Q) {
        scanf("%d%d", &b[i].l, &b[i].r);
        b[i].r++;
        b[i].id = i;
    }
    solve();
    For(i, 1, n) cout << h[i] << ' ';
}




