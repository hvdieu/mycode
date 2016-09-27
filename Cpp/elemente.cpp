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
#define BASE 1000003

int n, mu[N], res;
ll k, a[N];

int main() {
    freopen("elemente.in","r",stdin);
    freopen("elemente.out","w",stdout);
    cin >> n >> k;
    For(i, 1, n) scanf("%lld", &a[i]);
    mu[0] = 1; For(i, 1, n) mu[i] = (mu[i-1] * 2) % BASE;
    sort(a+1, a+n+1);
    int j = 1;
    For(i, 1, n) {
        while (j < n && a[j+1] - a[i] <= k) j++;
        res = (res + mu[j-i]) % BASE;
    }
    cout << res;
}
