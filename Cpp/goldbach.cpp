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
#define N 1000001

int p[N];
vector<int> prime;

void sieve() {
    int n = N-1, ss = trunc(sqrt(n));
    For(i, 2, ss) if (!p[i]) {
        int j = i*i;
        while (j <= n) {
            p[j] = 1; j += i;
        }
    }
    For(i, 2, n) if (!p[i]) prime.pb(i);
  //  cout << sz(prime);
}

int main() {
    freopen("goldbach.inp","r",stdin);
    freopen("goldbach.out","w",stdout);
    sieve();
    int n;
    while (scanf("%d", &n) != -1) {
        n *= 2;
        ll res = 0, sum = 0;
        For(i, 1, sz(prime)-1) if (prime[i] > n) break; else {
            int first = lower_bound(prime.begin(), prime.end(), n - prime[i]+1) - prime.begin();
            if (i < first) {
                sum++; first--;
            }
            if (first > 0) res += first-1;
        }
        cout << res / 2+1+sum << endl;
    }
}
