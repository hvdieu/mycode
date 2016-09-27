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

const int N = 1e5 + 5;
const int M = 1e9 + 7;

string s, t;
int n, m;
int nex[N], pos[N];
unsigned long long f[N], g[N], gg[N];

void init() {
   // cout << s << ' ' << t << "\n";
    nex[1] = 0;
    For(i, 2, m) {
        int j = nex[i-1];
        while (j && t[i] != t[j+1]) j = nex[j];
        if (t[i] == t[j+1]) nex[i] = j+1; else nex[i] = 0;
    }
    //For(i, 1, m) cout << nex[i] << ' ';
}

unsigned long long ans;

int main() {
    //freopen("in.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> s;
    cin >> t;
    s.insert(0, "a");
    t.insert(0, "a");
    n = sz(s)-1;
    m = sz(t)-1;
    init();
    //cout << s << ' ' << t << "\n";
    g[0] = f[0] = gg[0] = 1;
    int j = 0;
    For(i, 1, n) {
        pos[i] = pos[i-1];
        while (j && s[i] != t[j+1]) j = nex[j];
        if (s[i] == t[j+1]) j++;
        if (j == m) {
            pos[i] = i-j+1;
            j = nex[j];
        }
        //cout << j << ' ';
        if (pos[i]) f[i] = gg[pos[i]-1];
        g[i] = (g[i-1] + f[i]) % M;
        gg[i] = (gg[i-1] + g[i]) % M;
        ans = (ans + f[i]) % M;
        //cout << f[i] << ' ';
    }
   // cout << "\n" << pos[5] << "\n";
    cout << ans << "\n";
    /*For(i, 1, n) {
        Rep(j, i, 1) {
            string ss = s.substr(j, i-j+1);
            if (ss.find(t) != string::npos) {
                Rep(jj, j-1, 0) f[i] += f[jj];
            }
        }
    }
    For(i, 1, n) ans += f[i], cout << f[i] << ' ';
    cout << "\n"; cout << ans; */
}


