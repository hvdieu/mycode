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

const int MAX = 1e6 + 5;
const int N = 3e5 + 5;

int n, m;
vector<ii> P;
vector<int> Q[N];
int t[MAX];
int ans[N];

void update(int i, int val) {
    for(i; i <= 1000000; i += i & (-i)) t[i] += val;
}

int get(int i) {
    int ans = 0;
    for(i; i; i -= i & (-i)) ans += t[i];
    return ans;
}

void solve() {
    For(i, 1, m) {
        sort(all(Q[i]));
        Q[i].erase(unique(all(Q[i])), Q[i].end());
        FOR(x, Q[i]) P.pb(ii(*x, i));//, cout << *x << ' '; cout << "\n";
    }
    sort(all(P));
    FOR(it, P) {
        int x = it->fi, id = it->se;
       // cout << x <<  ' ' << id << "\n";
        if (id <= 0) {
            if (!id) update(x, 1);
            else update(-id, -1);
        } else {
            int j = lower_bound(all(Q[id]), x) - Q[id].begin();
            ans[id] += get(x);
            if (j) ans[id] -= get(Q[id][j-1]);
        }
    }
    For(i, 1, m) cout << ans[i] << "\n";
}

int main() {
    ios_base::sync_with_stdio(false);
   // freopen("in.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> m;
    For(i, 1, n) {
        int u, v;
        cin >> u >> v;
        P.pb(ii(u, 0));
        P.pb(ii(v+1, -u));
    }
    For(i, 1, m) {
        int k, x;
        cin >> k;
        For(j, 1, k) {
            cin >> x;
            Q[i].pb(x);
        }
    }
    solve();
}


