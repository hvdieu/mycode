#include <bits/stdc++.h>

using namespace std;
typedef pair<long long, long long> ii;
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

const int N = 1000 + 10;

int q, n;
int w[N];
vector<ii> ke[N];

int ln(ll x) {
    return int(log(x) / log(2));
}

int main() {
   // freopen("in.txt","r",stdin);
    cin >> q;
    For(i, 1, q) {
        int kind;
        ll u, v;
        cin >> kind >> u >> v;
        if (u > v) swap(u, v);
        if (kind == 1) {
            n++;
            cin >> w[n];
            while (ln(v) > ln(u)) {
                ke[n].pb(ii(v/2, v));
                v /= 2;
            }
            while (u != v) {
                ke[n].pb(ii(u/2, u));
                ke[n].pb(ii(v/2, v));
                u /= 2; v /= 2;
            }
            sort(all(ke[n]));
        } else {
            long long ans = 0;
            while (ln(v) > ln(u)) {
                ii pa = ii(v/2, v);
                For(j, 1, n) if (binary_search(all(ke[j]), pa)) ans += w[j];
                v /= 2;
            }
            while (u != v) {
                ii pa = ii(u/2, u);
                For(j, 1, n) if (binary_search(all(ke[j]), pa)) ans += w[j];
                pa = ii(v/2, v);
                For(j, 1, n) if (binary_search(all(ke[j]), pa)) ans += w[j];
                u /= 2; v /= 2;
            }
            cout << ans << "\n";
        }
    }
}


