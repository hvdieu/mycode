#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
#include <queue>
#include <stack>

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
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define two(i) (ll(1) << i)
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )

int dem[10], n;
ll k, fact[21];
int res[21];
char x[21];

ll Cal(int len) {
    ll res = fact[len];
    For(ch, 0, 9) res /= fact[dem[ch]];
    return res;
}

void Find(int i) {
    if (i > n) {
        For(j, 1, n) cout << res[j];
        return;
    }
    int bound = 0;
    if (i == 1) bound = 1;
    For(ch, bound, 9) if (dem[ch]) {
        dem[ch]--;
        ll x = Cal(n - i);
        if (k <= x) {
            res[i] = ch;
            Find(i + 1);
            return;
        } else k -= x;
        dem[ch]++;
    }
    cout << -1;
    return;
}

int main() {
    freopen("number.inp","r",stdin);
    freopen("number.out","w",stdout);
    cin >> k;
    cin >> (x+1);
    n = strlen(x+1);
    For(i, 1, n) dem[int(x[i]) - int('0')]++;
    fact[0] = 1;
    For(i, 1, 20) fact[i] = fact[i-1] * i;
    Find(1);
}
