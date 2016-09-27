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
#define N 10010

int n, k;
ll f[N], s[N];

int main() {
    freopen("guitar.inp","r",stdin);
    freopen("guitar.out","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) {
        int x; scanf("%d", &x);
        s[i] = s[i-1] + x;
    }
    For(i, 1, n) For(j, 1, min(k, i))
        int u = i - j + 1;
        if (u == 1)
    }
}
