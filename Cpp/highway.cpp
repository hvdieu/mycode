#include <bits/stdc++.h>

using namespace std;
typedef pair<long long, long long> ii;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 41

struct node {
    int u, tt;
    ll val, remain;
};

struct triple {
    int u, tt;
    ll remain;
};

make triple (int u, int tt, ll _remain) {
    triple x; x.remain = _remain; x.u = _u; x.tt
}

node make_node (ll _val, int _u, int _tt, ll _remain) {
    node x;
    x.val = _val; x.u = _u; x.tt = _tt; x.remain = _remain;
    return x;
}

bool operator < (const node &a, const node &b) {
    return a.val < b.val;
}

int n;
vector<ii> ke[N];
map<node, ll> d;
priority_queue<node
int t, s;
ll a[N][2], b[N][2], q[N];

void Dij(ll t) {
    d.erase(all(d));
}

int main() {
    freopen("highway.inp","r",stdin);
    freopen("highway.out","w",stdout);
    cin >> n >> t >> s;
    cin >> a[1][0] >> a[1][1] >> b[1][1];
    For(i, 2, n) cin >> q[i] >> a[i][0] >> a[i][1] >> b[i][1];
    Dij(t);
}
