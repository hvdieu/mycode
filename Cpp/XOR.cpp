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
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1LL << i))
#define N 110
#define M 100000
#define BASE 4294967295LL

int n, k;
ll a[N], ma, sum;

int dem(ll x) {
    return __builtin_popcount(x & BASE) + __builtin_popcount(x >> 32);
}

int main() {
    ios_base::sync_with_stdio(false);
    freopen("xor.inp","r",stdin);
    //freopen("xor.out","w",stdout);
    cin >> n;
    For(i, 1, n) {
        cin >> a[i]; ma = max(a[i], ma);
        sum ^= a[i];
    }
    while (two(k+1)-1 <= ma) k++;
    For(test, 1, M) {
        if (!sum) break;
        For(i, 1, n) {
            For(ii, 0, k) For(jj, ii+1, k) if (bit(a[i], ii) != bit(a[i], jj)) {
                ll x = a[i];
                if (bit(a[i], ii)) x -= two(ii); else x += two(ii);
                if (bit(a[i], jj)) x -= two(ii); else x += two(jj);
                if (dem(sum ^ a[i] ^ x) < dem(sum)) {
                    sum = sum ^ a[i] ^ x;
                    a[i] = x;
                }
            }
        }
    }
    if (sum) cout << -1;
    else For(i, 1, n) cout << a[i] << ' ';
}
