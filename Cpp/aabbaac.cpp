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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 51

int ntest, n, m;
string s[N];
ll len[N];

char Find(ll x, int i) {
    if (x > len[i] - sz(s[i])) return s[i][ x - len[i] + sz(s[i]) - 1 ];
    if (x <= len[i-1]) return Find(x, i-1);
    x -= len[i-1];
    return Find(len[i-1]-x+1, i-1);
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d%d\n", &n, &m);
        REP(i, n) cin >> s[i];
        len[0] = sz(s[0]);
        For(i, 1, n-1) len[i] = len[i-1]*2 + sz(s[i]);
        ll x;
        REP(i, m) {
            cin >> x;
            cout << Find(x+1, n-1);
        }
        cout << endl;
    }
}
