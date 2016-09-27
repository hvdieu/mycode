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
#define N 1010

bool del[N], flag, chuyen;
int n, m;
string a[N], b[N];
char s[N];
bool f[10][10];

bool cmp(string a, string b) {
    int m = sz(a)-1, n = sz(b)-1;
    reset(f, false);
    f[0][0] = true;
    For(i, 0, m) For(j, 0, n) if ((i || j) && a[i] != '*' && a[i] != '?' && b[j] != '*' && b[j] != '?') {
        if (i && j && a[i] == b[j]) f[i][j] |= f[i-1][j-1];
    } else {
        if (i && a[i] == '*') For(jj, 0, j) f[i][j] |= f[i-1][jj];
        if (j && b[j] == '*') For(ii, 0, i) f[i][j] |= f[ii][j-1];
        if (i && a[i] == '?') f[i][j] |= f[i-1][j-1];
        if (j && b[j] == '?') f[i][j] |= f[i-1][j-1];
    }
    return f[m][n];
}

void solve() {
    flag = true;
    For(i, 1, n) {
        bool ok = cmp(a[i], a[n+1]) & cmp(b[i], b[n+1]);
        if (ok != del[i]) flag = false;
    }
    cout << int(flag);
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("del.inp","r",stdin);
    freopen("del.out","w",stdout);
    cin >> n;
    For(i, 1, n) {
        char ch, sp;
        a[i].pb('0'); b[i].pb('0');
        cin >> ch >> s+1;
        m = strlen(s+1);
        if (ch == '-') del[i] = true;
        chuyen = false;
        For(j, 1, m) if (s[j] == '.') chuyen = true;
        else if (chuyen) b[i].pb(s[j]); else a[i].pb(s[j]);
        //cout << a[i] << ' ' << b[i] << endl;
    }
    cin >> s+1; m = strlen(s+1);
    int i = n+1; a[i].pb('0'); b[i].pb('0');
    chuyen = false;
    For(j, 1, m) if (s[j] == '.') chuyen = true;
    else if (chuyen) b[i].pb(s[j]); else a[i].pb(s[j]);
    //cout << a[n+1] << ' ' << b[n+1] << endl;
    solve();
}
