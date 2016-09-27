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
#define N 200010

int n, A, B, ntest;
bool dd[N];
vector<int> p;

void sieve() {
    int n = trunc(sqrt(1000000000));
    int ss = trunc(sqrt(n));
    bool d[n]; reset(d, true);
    For(i, 2, ss) if (d[i])
    for(int j = i*i; j <= n; j += i) d[j] = false;
    For(i, 2, n) if (d[i]) p.pb(i);
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    sieve();
    while (ntest) {
        ntest--;
        scanf("%d%d", &A, &B);
        reset(dd, true);
        For(i, 0, sz(p)-1) {
            int x = p[i];
            int j = max((A / x) * x, x*x);
            for(j; j <= B; j += x) if (j >= A) dd[j - A + 1] = false;
        }
        int res = 0;
        For(i, 1, B-A+1) if (dd[i]) res++;
        if (A == 1) res--;
        printf("%d\n", res);
    }
}
