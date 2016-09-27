#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
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
#define N 110

int n, a[N], dem;
char s[N];
bool flag;

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d\n", &n);
    For(i, 1, n) scanf("%s\n", s+1);
    For(i, 1, n) if (s[i] == '*') {
        if (s[i] != s[i-1]) a[i] = ++dem;
        else a[i] = dem;
    }
    For(len, 1, n) For(i1, 1, n) {
        int i2 = i1+len, i3 = i2 + len, i4 = i3 + len, i5 = i4 + len;
        if (i5 <= n && a[i1] && a[i2] && a[i3] && a[i4] && a[i5]) flag = true;
        //if (a[i1] != a[i2] && a[i2] != a[i3] && a[i3] != a[i4] && a[i4] != a[i5])
    }
    if (flag) cout << "yes"; else cout << "no";
}
