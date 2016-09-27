#include "alice.h"
#include <vector>
#include <cstring>
#include <cmath>
#include <math.h>
#include <algorithm>
#include <stdio.h>

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
#define N 1000010

int n, k;
bool p[N];
vector<int> prime;
int mu[32];

void sieve() {
    reset(p, true); p[1] = p[0] = false;
    int ss = trunc(sqrt(n));
    For(i, 2, ss) if (p[i])
    for(int j = i*i; j <= n; j += i) p[j] = false;
    For(i, 2, n) if (p[i]) prime.push_back(i);
   // reverse(all(prime));
}

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    n = get_n();
    sieve();
    k = 1;
    FOR(x, prime) {
        if (*x <= n / k) {
            if (is_divisible_by(*x)) {
                mu[0] = 1;
                int ans = 1, d = 2, c = 0, mid;
                For(i, 1, 60) {
                    mu[i] = mu[i-1] * (*x);
                    if (mu[i] <= n / k) c = i; else break;
                }
                while (d <= c) {
                    int mid = (d + c) / 2;
                    if (is_divisible_by(mu[mid])) {
                        ans = mid; d = mid + 1;
                    } else c = mid - 1;
                }
                k *= mu[ans];
            }
        }
    }
    guess(k);
}
