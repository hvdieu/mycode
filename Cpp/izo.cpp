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
#define N 100001

int n, a[N];
ll res;

int main() {
    freopen("izo.inp","r",stdin);
    freopen("izo.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i]);
        res += a[i];
    }
    sort(a+1,a+n+1);
    For(i, 1, n / 2) res += a[n - i + 1] - a[i];
    cout << res;
}
