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
#define N 50010

int n, s[N], dd[2*N], res;
ii a[N];

int id(int i) {
    return i + n;
}

int main() {
    freopen("lineup1.inp","r",stdin);
    freopen("lineup1.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d %d", &a[i].se, &a[i].fi);
    sort(a+1, a+1+n);
    For(i, 1, n) if (a[i].se) s[i] = s[i-1]+1; else s[i] = s[i-1]-1;
    reset(dd, 0xff);
    dd[id(0)] = a[1].fi;
    For(i, 1, n) {
        int x = dd[id(s[i])];
        if (x != -1) {
            res = max(res, a[i].fi - x);
        } else dd[id(s[i])] = a[i+1].fi;
    }
    cout << res;
}
