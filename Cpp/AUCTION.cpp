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

int n, m, A, B, p[N], len, res;
vector<int> prime;
ll mu[10];

void init() {
    int ss = trunc(sqrt(N-1));
    For(i, 2, ss) if (!p[i]) {
        int j = i*i;
        while (j < N) {
            p[j] = 1; j = j + i;
        }
    }
    For(i, 2, N-1) if (!p[i]) prime.pb(i);
}

bool check(ll x) {
	if (x == 1) return false;
    For(i, 0, sz(prime)-1) if (prime[i] >= x) return true;
    else if (x % prime[i] == 0) return false;
    return true;
}

int main() {
    freopen("auction.inp","r",stdin);
    freopen("auction.out","w",stdout);
    cin >> A >> B;
    init();
    For(i, 1, N-1) {
        ll x1 = i, y = i, x2 = i;
        x1 /= 10;
        while (y) {
            x1 = x1 * 10 + y % 10;
            x2 = x2 * 10 + y % 10;
            y /= 10;
        }
        if (x1 > B) break;
        if (x1 >= A && check(x1)) res++;
        if (x2 >= A && check(x2)) res++;
    }
    cout << res;
}
