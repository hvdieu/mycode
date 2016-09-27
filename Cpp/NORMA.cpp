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
#define all(x) x.begin(), x.end()
#define N 500010
#define BASE 1000000000
#define inf 1000000000

struct node {
    int sL, sm, sM, smL, sML, smM, smML;
    int memL, memm, memM;
};

int n, a[N], s[N], f[2][N][20], vmax;
ull res;
node t[4*N];
int p1[N], p2[N], top1, top2;

void trau() {
    For(i, 1, n) {
        int mi = inf, ma = 0;
        For(j, i, n) {
            mi = min(mi, a[j]); ma = max(ma, a[j]);
            res += (((ll(mi) * ma) % BASE) * (j-i+1)) % BASE;
            res %= BASE;
        }
    }
    cout << res;
}

void update_L(int i, int lo, int hi, int x) {
    int len = (hi-lo+1);
    t[i].sL = (ll(t[i].sL) + ll(x) * len) % BASE;
    t[i].smL = (ll(t[i].smL) + ll(t[i].sm) * x) % BASE;
    t[i].sML = (ll(t[i].sML) + ll(t[i].sM) * x) % BASE;
    t[i].smML = (ll(t[i].smML) + ll(t[i].smM) * x) % BASE;
}

void update_m(int i, int lo, int hi, int x) {
    int len = (hi-lo+1);
    t[i].sm = (ll(x) * len) % BASE;
    t[i].smL = (ll(x) * t[i].sL) % BASE;
    t[i].smM = (ll(x) * t[i].sM) % BASE;
    t[i].smML = (ll(x) * t[i].sML) % BASE;
}

void update_M(int i, int lo, int hi, int x) {
    int len = (hi-lo+1);
    t[i].sM = (ll(x) * len) % BASE;
    t[i].sML = (ll(x) * t[i].sL) % BASE;
    t[i].smM = (ll(x) * t[i].sm) % BASE;
    t[i].smML = (ll(x) * t[i].smL) % BASE;
}

void down(int i, int lo, int hi) {
    int mid = (lo + hi) / 2, c1 = i*2, c2 = i*2+1;
    if (t[i].memL) {
        t[c1].memL += t[i].memL; t[c1].memL %= BASE;
        t[c2].memL += t[i].memL; t[c2].memL %= BASE;
        update_L(c1, lo, mid, t[i].memL);
        update_L(c2, mid+1, hi, t[i].memL);
        t[i].memL = 0;
    }

    if (t[i].memm) {
        t[c1].memm = t[i].memm;
        t[c2].memm = t[i].memm;
        update_m(c1, lo, mid, t[i].memm);
        update_m(c2, mid+1, hi, t[i].memm);
        t[i].memm = 0;
    }

    if (t[i].memM) {
        t[c1].memM = t[i].memM;
        t[c2].memM = t[i].memM;
        update_M(c1, lo, mid, t[i].memM);
        update_M(c2, mid+1, hi, t[i].memM);
        t[i].memM = 0;
    }
}

void cc(int i) {
    int c1 = i*2, c2 = i*2+1;
    t[i].sL = (t[c1].sL + t[c2].sL) % BASE;
    t[i].sm = (t[c1].sm + t[c2].sm) % BASE;
    t[i].sM = (t[c1].sM + t[c2].sM) % BASE;
    t[i].smM = (t[c1].smM + t[c2].smM) % BASE;
    t[i].smL = (t[c1].smL + t[c2].smL) % BASE;
    t[i].sML = (t[c1].sML + t[c2].sML) % BASE;
    t[i].smML = (t[c1].smML + t[c2].smML) % BASE;
}

void inc_l(int i, int lo, int hi, int u, int v, int x) {
    if (lo == u && hi == v) {
        int len = hi-lo+1;
        update_L(i, lo, hi, x);
        t[i].memL++; if (t[i].memL >= BASE) t[i].memL %= BASE;
        return;
    }
    int mid = (lo + hi) / 2, c1 = i*2, c2 = i*2+1;
    down(i, lo, hi);
    if (u <= mid) inc_l(c1, lo, mid, u, min(mid, v), x);
    if (v > mid) inc_l(c2, mid+1, hi, max(mid+1, u), v, x);
    cc(i);
}

void set_m(int i, int lo, int hi, int u, int v, int x) {
    if (lo == u && hi == v) {
        update_m(i, lo, hi, x);
        t[i].memm = x;
        return;
    }
    int mid = (lo+hi)/2, c1 = i*2, c2 = i*2+1;
    down(i, lo, hi);
    if (u <= mid) set_m(c1, lo, mid, u, min(mid, v), x);
    if (v > mid) set_m(c2, mid+1, hi, max(mid+1, u), v, x);
    cc(i);
}

void set_M(int i, int lo, int hi, int u, int v, int x) {
    if (lo == u && hi == v) {
        update_M(i, lo, hi, x);
        t[i].memM = x;
        return;
    }
    int mid = (lo+hi)/2, c1 = i*2, c2 = i*2+1;
    down(i, lo, hi);
    if (u <= mid) set_M(c1, lo, mid, u, min(mid, v), x);
    if (v > mid) set_M(c2, mid+1, hi, max(mid+1, u), v, x);
    cc(i);
}

void solve() {
    For(i, 1, n) {
        while (top1 && a[p1[top1]] >= a[i]) top1--; /* aj < ai */
        while (top2 && a[p2[top2]] <= a[i]) top2--; /* aj > ai */
        inc_l(1, 1, n, 1, i, 1);
        set_m(1, 1, n, p1[top1]+1, i, a[i]);
        set_M(1, 1, n, p2[top2]+1, i, a[i]);
        res = (res + t[1].smML) % BASE;
        p1[++top1] = i; p2[++top2] = i;
    }
    cout << res;
}

int main() {
    freopen("norma.inp","r",stdin);
    //freopen("norma.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i]);
        s[i] = s[i-1] + i;
        if (s[i] >= BASE) s[i] %= BASE;
    }
    //trau();
    solve();
}

