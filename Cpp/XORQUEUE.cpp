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
#define bit(x, i) ((x >> i) & 1)
#define N 400010
#define BUG 1
int n, d[N*50][2], f[N*50], cnt, lef, righ;
ll a[N], b[N], A, B, k, c[N];

void push(ll x) {
    int t = 0;
    Rep(i, 50, 0) {
        int ch = bit(x, i);
        if (!d[t][ch]) {
            cnt++; d[t][ch] = cnt;
            t = cnt; f[t]++;
        } else {
            t = d[t][ch];
            f[t]++;
        }
    }
}

void pop(ll x) {
    int t = 0;
    Rep(i, 50, 0) {
        int ch = bit(x, i);
        t = d[t][ch]; f[t]--;
    }
}

int Cal(ll x) {
	if (x < 0) return 0;
    int res = 0, t = 0;
    Rep(i, 50, 0) {
        int c1 = bit(k, i), c2 = bit(x, i);
        if (c2) {
            res += f[d[t][c1]];
            t = d[t][1-c1];
        } else t = d[t][c1];
        if (!t) return res;
    }
    res += f[t];
    return res;
}

int main() {
    std::ios::sync_with_stdio(false);
    freopen("XORQUEUE.INP","r",stdin);
    freopen("XORQUEUE.OUT","w",stdout);
    cin >> n;
    For(i, 1, n) {
        cin >> a[i];
        b[i] = b[i-1] ^ a[i];
        c[i] = b[i];
        push(b[i]);
    }
    lef = 0; righ = n;
    int ntest;
    cin >> ntest;
    while (ntest) {
        ntest--;
        string kind;
        cin >> kind;
        if (kind == "POP") {
            lef++;
            pop(b[lef]);
            //For(i, lef+1, righ) c[i] ^= a[lef];
        } else if (kind == "PUSH") {
            ll x; cin >> x;
            righ++; b[righ] = b[righ-1] ^ x;
            //c[righ] = c[righ-1] ^ x;
            push(b[righ]);
           // a[righ] = x;
        } else {
            cin >> A >> B;
            k = b[lef];
            if (A > B) cout << 0 << endl;
            else {
            ll res = Cal(B) - Cal(A-1);
            ll r1 = 0;
            //For(i, lef+1, righ) if (c[i] >= A && c[i] <= B) r1++;
            if (BUG) cout << res << endl;
            else cout << r1 << endl;
            }
        }
    }
}
