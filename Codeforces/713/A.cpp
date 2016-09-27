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

const int N = 1e5 + 10;

int ntest, m;
int d[N*2*18][2], f[N*2*18];
string s;
char kind;

int get() {
    int t = 0;
    for(int i = sz(s)-1; i >= 0; i--) {
        int dir = (s[i] - '0') % 2;
        if (!d[t][dir]) return 0;
        t = d[t][dir];
    }
    return f[t];
}

void update(int x) {
    int t = 0;
    for(int i = sz(s)-1; i >= 0; i--) {
        int dir = (s[i] - '0') % 2;
        if (!d[t][dir]) d[t][dir] = ++m;
        t = d[t][dir];
        f[t] += x;
    }
}

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("in.txt","r",stdin);
    cin >> ntest;
    while (ntest--) {
        cin >> kind >> s;
        while (sz(s) < 18) s = "0" + s;
        if (kind == '?') cout << get() << "\n";
        else if (kind == '+') update(1);
        else update(-1);
    }
}


