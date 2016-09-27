#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 100010
#define BASE 1000000009

int n, m, q, p, dem, id[N];
ll t[4*N], f[4*N], a[N];
vector<int> s[N];
ll sum[N], tang[N];
vector<int> big[N];
vector<int> type2;
int chung[400][400];
vector<int> ds;

void down(int i, int lo, int hi) {
    int mid = (lo + hi) / 2, c1 = i*2, c2 = c1+1;
    f[c1] = (f[c1] + f[i]) % BASE; f[c2] = (f[c2] + f[i]) % BASE;
    t[c1] += (ll(f[i])*(mid-lo+1)) % BASE; t[c2] += (ll(f[i])*(hi-mid)) % BASE;
    t[c1] %= BASE; t[c2] %= BASE;
    f[i] = 0;
}

void update(int i, int lo, int hi, int u, int v, int x) {
    if (u <= lo && hi <= v) {
        t[i] += (ll(x) * (hi - lo + 1)) % BASE;
        if (t[i] >= BASE) t[i] -= BASE;
        f[i] += x; if (f[i] >= BASE) f[i] -= BASE;
        return;
    }
    if (lo > v || hi < u) return;
    int mid = (lo + hi) / 2;
    down(i, lo, hi);
    update(i*2, lo, mid, u, v, x);
    update(i*2+1, mid+1, hi, u, v, x);
    t[i] = (t[i*2] + t[i*2+1]) % BASE;
}

int get(int i, int lo, int hi, int u, int v) {
    if (u <= lo && hi <= v) return t[i];
    if (lo > v || hi < u) return 0;
    int mid = (lo + hi) / 2;
    down(i, lo, hi);
    return (get(i*2, lo, mid, u, v) + get(i*2+1, mid+1, hi, u, v)) % BASE;
}

void trau() {
    For(qq, 1, q) {
        int kind, u, v, x;
        scanf("%d", &kind);
        if (kind == 1) {
            scanf("%d%d", &u, &v);
            FOR(i, s[u]) a[*i] = (a[*i] + v) % BASE;
        } else if (kind == 2) {
            scanf("%d", &u);
            ll res = 0;
            FOR(i, s[u]) res = (res + a[*i]) % BASE;
            cout << res << endl;
        } else if (kind == 3) {
            scanf("%d%d%d", &u, &v, &x);
            For(i, u, v) a[i] = (a[i] + x) % BASE;
        } else {
            scanf("%d%d", &u, &v);
            ll res = 0;
            For(i, u, v) res = (res + a[i]) % BASE;
            cout << res << endl;
        }
    }
}

int dd[N];

void init() {
    For(i, 0, sz(ds)-1) {
        FOR(it, s[ds[i]]) dd[*it]++;
        For(j, 0, sz(ds)-1)
        FOR(it, s[ds[j]]) chung[ds[i]][ds[j]] += dd[*it];
        FOR(it, s[ds[i]]) dd[*it]--;
    }
}

void solve() {
	FOR(i, ds) sort(all(s[*i]));
    For(qq, 1, q) {
        int kind, u, v, x;
        scanf("%d", &kind);
        if (kind == 1) {
            scanf("%d%d", &u, &v);
            if (sz(s[u]) <= p) {
                FOR(i, s[u]) {
                	update(1, 1, n, *i, *i, v);
                	FOR(j, big[*i]) sum[*j] = (sum[*j] + v) % BASE;
				}
            } else {
                tang[u] = (tang[u] + v) % BASE;
                FOR(i, ds) sum[*i] = (sum[*i] + ll(chung[u][*i])*v) % BASE;
            }
        } else if (kind == 2) {
            scanf("%d", &u);
            ll res = 0;
            if (sz(s[u]) <= p) {
                FOR(i, s[u]) {
                    res = (res + get(1, 1, n, *i, *i)) % BASE;
                    FOR(j, big[*i]) res = (res + tang[*j]) % BASE;
                }
            } else {
                res = sum[u];
            }
            printf("%d\n", res);
        } else if (kind == 3) {
            scanf("%d%d%d", &u, &v, &x);
            update(1, 1, n, u, v, x);
            FOR(i, ds) {
                int uu = lower_bound(all(s[*i]), u) - s[*i].begin();
                int vv = upper_bound(all(s[*i]), v) - s[*i].begin() - 1;
                if (uu < sz(s[*i]) && vv >= 0) sum[*i] = (sum[*i] + ll(x)*(vv-uu+1)) % BASE;
            }
        } else {
            scanf("%d%d", &u, &v);
            ll res = get(1, 1, n, u, v);
            FOR(i, ds) {
                int uu = lower_bound(all(s[*i]), u) - s[*i].begin();
                int vv = upper_bound(all(s[*i]), v) - s[*i].begin() - 1;
                if (uu < sz(s[*i]) && vv >= 0) res = (res + tang[*i]*(vv-uu+1)) % BASE;
            }
            cout << res << endl;
        }
    }
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d%d", &n, &m, &q);
    p = trunc(sqrt(n));
    For(i, 1, m) {
        int nn; scanf("%d", &nn);
        if (nn > p) id[i] = dem++, ds.pb(i);
        For(j, 1, nn) {
            int x; scanf("%d", &x);
            s[i].pb(x);
            if (nn > p) big[x].pb(i);
        }
    }
    //trau();
  //  cout << sz(ds) << endl;
    init();
    solve();
}


