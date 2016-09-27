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
#define N 100010

int n, a[N], f[N], t[N];

void update(int i, int val) {
    while (i <= 100000) {
        t[i] = max(t[i],val);
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
    For(i,1,n) {
        f[i] = get(a[i]) + 1;
        update(a[i], f[i]);
    }

    //cout << n - f[n];
    For(i, 1, n) cout << f[i] << ' ';
}


int main() {
    freopen("lock.inp","r",stdin);
    freopen("lock.out","w",stdout);
    scanf("%d", &n);
    For(i,1,n) scanf("%d", &a[i]);
    solve();
}
