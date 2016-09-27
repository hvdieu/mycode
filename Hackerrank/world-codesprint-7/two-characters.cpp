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

const int N = 1000 + 10;

int n;
char s[N];
int ans;

int main() {
    //freopen("in.txt","r",stdin);
    scanf("%d\n", &n);
    scanf("%s\n", s+1);
    REP(c1, 26) REP(c2, 26) if (c1 != c2) {
        bool ok = true;
        int l = 0, tmp = 0;
        For(i, 1, n) {
            if (s[i]-'a' == c1) tmp++, l++;
            if (s[i]-'a' == c2) tmp--, l++;
            if (tmp < 0 || tmp > 1) ok = false;
        }
        if (ok && l > 1) {
            ans = max(ans, l);
           // cout << c1 <<  ' ' << c2 << "\n";
        }
    }
    cout << ans;
}


