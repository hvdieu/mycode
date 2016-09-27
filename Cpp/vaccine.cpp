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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 210
#define M 10010

int n, m, ntest, t[510], len;
char a[M], b[N][510];
vector<int> pos[2][26];
vector<ii> Q;
vector<int> tmp;

void update(int i, int val) {
    while (i <= len) {
        t[i] = max(t[i], val);
        i += i & (-i);
    }
}

int get(int i) {
    int s = 0;
    while (i) {
        s = max(s, t[i]);
        i -= i & (-i);
    }
    return s;
}

void solve() {
    int res = 0;
    m = strlen(a+1);
    For(ch, 0, 25) pos[0][ch].clear();
    For(i, 1, m) pos[0][int(a[i]) - int('A')].pb(i);
    For(i, 1, n) {
        Q.clear();
        len = strlen(b[i]+1);
        For(j, 1, len) pos[1][int(b[i][j]) - int('A')].pb(j);
        For(ch, 0, 25) {
            For(x, 0, sz(pos[0][ch])-1) For(y, 0, sz(pos[1][ch])-1)
            Q.pb(ii(pos[0][ch][x], pos[1][ch][y]));
            pos[1][ch].clear();
        }
        sort(Q.begin(), Q.end());
        reset(t, 0);
        int ff = 0;
        while (ff < sz(Q)) {
            int rr = ff;
            while (rr < sz(Q)-1 && Q[rr+1].fi == Q[ff].fi) rr++;
            tmp.clear();
            For(k, ff, rr) {
                int x = get(Q[k].se - 1) + 1;
                res = max(res, x);
                tmp.pb(x);
            }

            For(k, ff, rr) update(Q[k].se, tmp[k-ff]);
            ff = rr + 1;
        }
    }
    cout << res << endl;
}

int main() {
    freopen("vaccine.inp","r",stdin);
    freopen("vaccine.out","w",stdout);
    scanf("%d\n", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d\n", &n);
        scanf("%s\n", (a+1));
        For(i, 1, n) scanf("%s\n", (b[i]+1));
        solve();
    }
}
