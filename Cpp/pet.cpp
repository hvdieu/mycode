#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
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
#define bit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1LL << (i-1)))
#define N 7

struct node {
    int i, j, home, oncar;
    node(int _i, int _j, int _home, int _oncar) {
        i = _i; j = _j; home = _home; oncar = _oncar;
    }
};

const int h[4] = {-1, 0, 1, 0};
const int c[4] = {0, 1, 0, -1};

int m, n, a[N][N], d[N][N][4], si, sj, k, id[2049];
queue<node> q[2];
int f[N][N][2049][363];
vector<int> l;
int tt[12];

void update(int val, int i, int j, int home, int oncar) {
        int cnt = __builtin_popcount(oncar);
        if (a[i][j] > 0 && !bit(home, a[i][j]) && !bit(oncar, a[i][j]) && cnt < 4) {
            int newoncar = onbit(oncar, a[i][j]);
            if (f[i][j][home][id[newoncar]] > val) {
                f[i][j][home][id[newoncar]] = val;
                q[0].push(node(i, j, home, newoncar));
            }
        }
        if (a[i][j] < 0 && !bit(home, -a[i][j]) && bit(oncar, -a[i][j])) {
            int newhome = onbit(home, -a[i][j]);
            int newoncar = offbit(oncar, -a[i][j]);
            if (f[i][j][newhome][id[newoncar]] > val) {
                f[i][j][newhome][id[newoncar]] = val;
                q[0].push(node(i, j, newhome, newoncar));
            }
        }
        For(kk, 0, 3) if (d[i][j][kk]) {
            int u = i + h[kk], v = j + c[kk];
            if (f[u][v][home][id[oncar]] > val + 1) {
                f[u][v][home][id[oncar]] = val + 1;
                q[1].push(node(u, v, home, oncar));
            }
        }
}

void solve() {
    reset(f, 0x7f);
    f[si][sj][0][0] = 0;
    q[0].push(node(si, sj, 0, 0));
    while (1) {
    	if (q[0].empty() && q[1].empty()) {
    		cout << "-1" << endl;
    		return;
		}
        int t = 0;
        if (q[0].empty()) t = 1;
        int i = q[t].front().i, j = q[t].front().j, home = q[t].front().home, oncar = q[t].front().oncar;
        q[t].pop();
        int val = f[i][j][home][id[oncar]];
        if (home == (1 << k)-1) {
            cout << val; return;
        }
        update(val, i, j, home, oncar);
    }
}

void init() {
    For(tt, 0, (1 << k)-1) {
        int cnt = __builtin_popcount(tt);
        if (cnt <= 4) l.pb(tt);
    }
    sort(all(l));
    //cout << sz(l) << endl;
    For(j, 0, sz(l)-1) id[l[j]] = j;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    cin >> m >> n;
    For(i, 1, m) For(j, 1, n) {
        cin >> a[i][j];
        if (a[i][j] == 99) si = i, sj = j;
        else k = max(k, a[i][j]);
    }
    For(i, 1, m) For(j, 1, n-1) {
        int x; cin >> x; d[i][j][1] = d[i][j+1][3] = x;
    }
    For(i, 1, m-1) For(j, 1, n) {
        int x; cin >> x; d[i][j][2] = d[i+1][j][0] = x;
    }
    init();
    solve();
}
