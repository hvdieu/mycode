#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
#include <queue>
#include <stack>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef long double ld;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 30010
#define inf 1000000001

struct node {
    int mem;
    ll sum;
};

int n, m, a[N];
node t[8*N];
ll s;

void init(int i, int lo, int hi) {
    t[i].mem = inf;
    if (lo == hi) {
        t[i].sum = a[lo];
        return;
    }
    int mid = (lo+hi) / 2;
    init(i*2, lo, mid); init(i*2+1, mid+1, hi);
    t[i].sum = t[i*2].sum + t[i*2+1].sum;
}

void down(int i, int lo, int hi) {
    int c1 = i*2, c2 = i*2+1, mid = (lo+hi) / 2;
    if (t[i].mem < inf) {
        t[c1].mem = t[c2].mem = t[i].mem;
        t[c1].sum = ll(t[c1].mem)*(mid-lo+1);
        t[c2].sum = ll(t[c2].mem)*(hi-mid);
        t[i].mem = inf;
    }
}

ll get(int i, int lo, int hi, int u, int v) {
    if (lo == u && hi == v) return t[i].sum;
    int mid = (lo + hi) / 2;
    down(i, lo, hi);
    ll res = 0;
    if (u <= mid) res += get(i*2, lo, mid, u, min(mid, v));
    if (v > mid) res += get(i*2+1, mid+1, hi, max(u,mid+1), v);
    t[i].sum = t[i*2].sum + t[i*2+1].sum;
    return res;
}

void update(int i, int lo, int hi, int u, int v, int x) {
    if (lo == u && hi == v) {
        t[i].sum = ll(x) * (hi-lo+1);
        t[i].mem = x;
        return;
    }
    down(i, lo, hi);
    int mid = (lo + hi) / 2;
    if (u <= mid) update(i*2, lo, mid, u, min(mid, v), x);
    if (v > mid) update(i*2+1, mid+1, hi, max(u, mid+1), v, x);
    t[i].sum = t[i*2].sum + t[i*2+1].sum;
}

int main() {
    freopen("universe.inp","r",stdin);
   // freopen("universe.out","w",stdout);
    int dem = 0;
    while (scanf("%d%d", &n, &m) != -1) {
    s = 0;
    For(i, 1, n) {
        scanf("%d", &a[i]);
        s += a[i];
    }
    init(1, 1, n);
    while (m) {
        m--;
        int u, v;
        scanf("%d%d", &u, &v);
        ll newS = t[1].sum;
        ll x = get(1, 1, n, u, v);
        ld y = ld(x) / (v-u+1);
        int val;
        if (newS <= s) val = ceil(y);
        else val = floor(y);
        update(1, 1, n, u, v, val);
    }
    For(i, 1, n-1) printf("%d ", get(1, 1, n, i, i));
    printf("%d\n\n", get(1, 1, n, n, n));
    }
}
