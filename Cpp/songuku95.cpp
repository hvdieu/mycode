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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 110

int ntest, n;
string s;

bool kt(string s) {
    if (!sz(s)) return true;
    For(i, 0, sz(s)-2) if (s[i] == s[i+1]) return false;
    return true;
}

bool check(string &s, int n, int vt) {
    if (!sz(s)) return true;
    if (n == 1) {
        if (s[0] == 'L' && !vt) return true;
        return false;
    }
    string sa, sb;
    for(int i = 0; i < sz(s); i += 2) sa.pb(s[i]);
    for(int i = 1; i < sz(s); i += 2) sb.pb(s[i]);
    if (kt(sa) && vt) {
        if ((!sz(sa) || sa[0] == 'L') && check(sb, n-1, 1)) return true;
        else if ((!sz(sa) ||sa[0] == 'R') && check(sb, n-1, 0)) return true;
    }
    if (kt(sb) && !vt) {
        if ((!sz(sb) || sb[0] == 'L') && check(sa, n-1, 0)) return true;
        else if ((!sz(sb) || sb[0] == 'R') && check(sa, n-1, 1)) return true;
    }
    return false;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("d.inp","r",stdin);
    freopen("d.out","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        cin >> n >> s;
        printf("Case %d: ", test);
        if (check(s, n, 0) || check(s, n, 1)) printf("Yes\n");
        else printf("No\n");
    }
}
