#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(auto i : f)
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

const int N = 100 + 10;

int ntest, n;
vector<int> ke[2*N];
bool fr[2*N];
ii live[N], rep[N];
int L, R;

bool giao(ii a, ii b) {
    if (a.fi > b.fi) swap(a, b);
    return b.fi <= a.se;
}

int node(int i, int t) {
    if (!t) return 2*i-1;
    return 2*i;
}

void buildGraph() {
    For(i, 1, 2*n) ke[i].clear();
    For(i, 1, n) For(j, i+1, n) {
        if (giao(live[i], live[j])) {
            ke[node(i, 0)].pb(node(j, 1));
            ke[node(j, 0)].pb(node(i, 1));
        }
        if (giao(live[i], rep[j])) {
            ke[node(i, 0)].pb(node(j, 0));
            ke[node(j, 1)].pb(node(i, 1));
        }
        if (giao(rep[i], live[j])) {
            ke[node(i, 1)].pb(node(j, 1));
            ke[node(j, 0)].pb(node(i, 0));
        }
        if (giao(rep[i], rep[j])) {
            ke[node(i, 1)].pb(node(j, 0));
            ke[node(j, 1)].pb(node(i, 0));
        }
    }
}

int LL, RR, top, st[2*N], timer, lab[2*N], cnt;
int num[2*N], low[2*N];

void dfs(int u) {
    num[u] = ++timer; low[u] = num[u];
    st[++top] = u;
    FOR(v, ke[u]) if (v >= LL && v <= RR && fr[v]) {
        if (!num[v]) {
            dfs(v);
            low[u] = min(low[u], low[v]);
        } else low[u] = min(low[u], num[v]);
    }
    if (low[u] == num[u]) {
        cnt++; int v;
        do {
            v = st[top--];
            fr[v] = false;
            lab[v] = cnt;
        } while (u != v);
    }
}

bool solve(int l, int r) {
    reset(fr, true);
    LL = node(l, 0); RR = node(r, 1);
    reset(num, 0);
    timer = cnt = 0;
    For(i, LL, RR) if (!num[i]) {
        top = 0;
        dfs(i);
    }
    for(int u = LL; u <= RR; u += 2)
        if (lab[u] == lab[u+1]) return false;
    return true;
}

bool check(int len) {
    For(i, 1, n-len+1) {
        int j = i + len - 1;
        if (solve(i, j)) {
            L = i; R = j;
            return true;
        }
    }
    return false;
}

int main() {
    //freopen("in.txt","r",stdin);
    cin >> ntest;
    while (ntest--) {
        cin >> n;
        For(i, 1, n) cin >> live[i].fi >> live[i].se >> rep[i].fi >> rep[i].se;
        buildGraph();
        int lef = 1, righ = n, mid, ans;
        L = R = 1;
        while (lef <= righ) {
            mid = (lef + righ) / 2;
            if (check(mid)) {
                ans = mid;
                lef = mid + 1;
            } else righ = mid - 1;
        }
        cout << L << ' ' << R << "\n";
    }
}


