#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;
typedef vector<int> VI;

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
#define N 100010

int n, d, k, ntest, nn;
int dis[N], inq[N], dem, bb[N];
queue<VI> q;
ll res;

inline int id(VI a) {
    int res = 0, base = nn / n;
    For(j, 0, d-1) res += (a[j]-1)*base, base /= n;
    return ++res;
}

inline void bfs(VI start) {
    res -= dis[id(start)]; dis[id(start)] = 0;
    q.push(start);
    while (!q.empty()) {
        VI u = q.front(); q.pop();
        int uu = id(u);
        For(j, 0, d-1) {
            int vv;
            u[j]--; if (u[j]) {
                vv = uu - bb[j];
                if (dis[vv] > dis[uu] + 1) {
                    res -= dis[vv]; dis[vv] = dis[uu] + 1;
                    res += dis[vv];
                    q.push(u);
                }

            } u[j]++;
            u[j]++; if (u[j] <= n) {
                vv = uu + bb[j];
                if (dis[vv] > dis[uu] + 1) {
                    res -= dis[vv]; dis[vv] = dis[uu] + 1;
                    res += dis[vv];
                    q.push(u);
                }
            } u[j]--;
        }
    }
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d%d", &n, &d, &k);
        reset(dis, 0x7f);
        res = 0; nn = pow(n, d);
        bb[0] = nn/n;
        For(i, 1, d-1) bb[i] = bb[i-1]/n; For(i, 1, nn) res += dis[i];
        VI start;
        For(i, 1, k) {
            start.clear();
            For(j, 1, d) {
                int x; scanf("%d", &x); start.pb(x);
            }
            bfs(start);
            printf("%lld\n", res);
        }
    }
}
