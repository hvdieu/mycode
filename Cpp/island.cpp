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
#define N 1000010

int n, res, kq;
ii a[N];
bool dd[N];

int main() {
    freopen("island.inp","r",stdin);
    freopen("island.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i].fi);
        a[i].se = i;
    }
    sort(a+1, a+n+1);
    int i = n;
    while (i) {
        int j = i; while (j > 1 && a[i].fi == a[j-1].fi) j--;
        For(k, j, i) {
            int u = a[k].se;
            if (!dd[u-1] && !dd[u+1]) res++;
            else if (dd[u-1] && dd[u+1]) res--;
            dd[u] = true;
        }
        i = j-1;
        kq = max(kq, res);
    }
    cout << kq;
}
