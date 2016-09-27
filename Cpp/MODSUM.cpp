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
#define N 1001

int n, a[N], b[N], res;

void dfs(int i, int s) {
    if (i > n) {
        s = s % 5;
        res += (s*s*s*s + 2*s*s) % 5 + 1;
        return;
    }
    For(j, a[i], b[i]) dfs(i+1, s + j);
}

int main() {
    freopen("modsum.inp","r",stdin);
    freopen("modsum.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &a[i], &b[i]);
    dfs(1, 0);
    cout << res;
}
