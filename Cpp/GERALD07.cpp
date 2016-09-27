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
#define N 200010

struct query {
    int l, r, id;
};

struct DSU {
    int r1, l1, r2, l2;
    DSU(int a, int b, int c, int d) { r1 = a; l1 = b; r2 = c; l2 = d; }
};

int n, m, ntest, q, p, res;
int x[N], y[N];
int root[2][N], kq[N];
query Q[N];
vector<DSU> st[2];

bool cmp(query a, query b) {
    if ((a.l / p) != (b.l / p)) return (a.l / p) < (b.l / p);
    return a.r < b.r;
}

int getroot(int t, int u) {
    while (root[t][u] > 0) u = root[t][u];
    return u;
}

void Union(int r1, int r2, int t, int backup) {
    if (backup) st[t].push_back(DSU(r1, root[t][r1], r2, root[t][r2]));
    int x = root[t][r1] + root[t][r2];
    if (root[t][r1] > root[t][r2]) {
        root[t][r1] = r2; root[t][r2] = x;
    } else {
        root[t][r2] = r1; root[t][r1] = x;
    }
}

void Restore(int t) {
    while (!st[t].empty()) {
        if (t) res++;
        DSU E = st[t].back();
        st[t].pop_back();
        root[t][E.r1] = E.l1;
        root[t][E.r2] = E.l2;
    }
}

int len(int i) {
    return Q[i].r - Q[i].l + 1;
}

void brute(int i) {
    int res = n;
    For(j, Q[i].l, Q[i].r) {
        int r1 = getroot(0, x[j]), r2 = getroot(0, y[j]);
        if (r1 != r2) {
            res--; Union(r1, r2, 0, 1);
        }
    }
    kq[Q[i].id] = res;
    Restore(0);
}

void solve() {
    p = trunc(sqrt(m));
    sort(Q+1, Q+q+1, cmp);
    Q[0].l = -1000000000;
    For(i, 1, n) root[0][i] = root[1][i] = -1;
    int MAX;
    For(i, 1, q) {
        if (len(i) <= p) brute(i); else {
            if ((Q[i].l / p) != (Q[i-1].l / p) || len(i-1) <= p) {
                MAX = (Q[i].l/p + 1)*p-1;
                res = n;
                For(j, 1, n) root[1][j] = -1;
                For(j, MAX+1, Q[i].r) {
                    int r1 = getroot(1, x[j]), r2 = getroot(1, y[j]);
                    if (r1 != r2) {
                        Union(r1, r2, 1, 0);
                        res--;
                    }
                }
                Rep(j, MAX, Q[i].l) {
                    int r1 = getroot(1, x[j]), r2 = getroot(1, y[j]);
                    if (r1 != r2) {
                        Union(r1, r2, 1, 1);
                        res--;
                    }
                }
                kq[Q[i].id] = res;
                Restore(1);
            } else {
                For(j, Q[i-1].r+1, Q[i].r) {
                    int r1 = getroot(1, x[j]), r2 = getroot(1, y[j]);
                    if (r1 != r2) {
                        res--; Union(r1, r2, 1, 0);
                    }
                }
                Rep(j, MAX, Q[i].l) {
                    int r1 = getroot(1, x[j]), r2 = getroot(1, y[j]);
                    if (r1 != r2) {
                        Union(r1, r2, 1, 1);
                        res--;
                    }
                }
                kq[Q[i].id] = res;
                Restore(1);
            }
    	}
       // For(j, 0, sz(st)-1) printf("%d ", st[j].id); printf("\n");
    }
}

void trau() {
    For(i, 1, q) {
        For(j, 1, n) root[1][j] = -1;
        res = n;
        For(j, Q[i].l, Q[i].r) {
            int r1 = getroot(1, x[j]), r2 = getroot(1, y[j]);
            if (r1 != r2) {
                res--;
                Union(r1, r2, 1, 0);
            }
        }
        kq[i] = res;
    }
}

void inkq() {
    For(i, 1, q) printf("%d\n", kq[i]);
}

int main() {
    //ios_base::sync_with_stdio(false);
  //  freopen("input.inp","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d%d", &n, &m, &q);
        For(i, 1, m) {
            scanf("%d%d", x+i, y+i);
        }
        For(i, 1, q) {
            scanf("%d%d", &Q[i].l, &Q[i].r);
            Q[i].id = i;
        }
        solve();
        //trau();
        inkq();
    }
}
