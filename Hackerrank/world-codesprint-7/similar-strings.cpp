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

const int N = 5e4 + 10;
const int base = 47;

struct triple {
    int fi, se, id;
    triple(int _fi, int _se, int _id) {
        fi = _fi; se = _se; id = _id;
    }
};

bool cmp(triple a, triple b) {
    if (a.fi != b.fi) return a.fi < b.fi;
    return a.se < b.se;
}

int n, ntest;
vector<ii> pos[N];
char s[N];
ull h[N][10], pw[N];
vector<triple> Q;
set<int> p;
int ans[N];
vector<set<int>::iterator> st;

int getHash(int i, int j, int t) {
    return h[j][t] - h[i-1][t] * pw[j-i+1];
}

void init() {
    pw[0] = 1;
    For(i, 1, n) {
        pw[i] = pw[i-1] * base;
        REP(j, 10) h[i][j] = h[i-1][j] * base + (s[i]-'a' == j);
    }
    int id[10];
    REP(i, 10) id[i] = n+1;
    Rep(i, n, 1) {
        REP(j, 10) pos[i].pb(ii(id[j], j));
        sort(all(pos[i]));
        id[s[i]-'a'] = i;
    }
}

int solve(int i, int j, int L, int R) {
    int len = R - L + 1;
    REP(k, 10) {
        if (pos[i][k].fi > j) {
            if (pos[L][k].fi <= R) return false;
            break;
        }

        if (pos[L][k].fi > R) {
            if (pos[i][k].fi <= j) return false;
			break;
		}
        if (getHash(i, j, pos[i][k].se) != getHash(L, R, pos[L][k].se)) return false;
    }
    return true;
}

int main() {
    freopen("in.txt","r",stdin);
    freopen("out.txt", "w", stdout);
    scanf("%d%d", &n, &ntest);
    scanf("%s\n", s+1);
    init();
    REP(i, ntest) {
        int L, R;
        scanf("%d%d\n", &L, &R);
        Q.pb(triple(L, R, i));
    }
    sort(all(Q), cmp);
    REP(k, sz(Q)) {
        if(!k || Q[k].fi != Q[k-1].fi) {
            p.clear();
            For(i, 1, n) p.insert(i);
        }
        FOR(it, p) {
            int i = *it, j = i + Q[k].se - Q[k].fi;
            if (solve(i, j, Q[k].fi, Q[k].se)) ans[Q[k].id]++;
            else st.pb(it);
        }
        REP(i, sz(st)) p.erase(st[i]);
        st.clear();
      //  cout << k << "\n";
    }
    REP(i, ntest) cout << ans[i] << "\n";
}


