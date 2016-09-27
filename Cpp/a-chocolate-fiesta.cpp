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
#define BASE 1000000007
#define N 100010

int n, a[N], f[N][2];

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i]);
        a[i] %= 2;
    }
    f[0][0] = 1;
    For(i, 1, n) {
        For(j, 0, 1) f[i][j] = f[i-1][j];
        if (!a[i]) For(j, 0, 1) f[i][j] = (f[i][j] + f[i-1][j]) % BASE;
        else For(j, 0, 1) f[i][j] = (f[i][j] + f[i-1][1-j]) % BASE;
    }
    cout << (f[n][0] - 1 + BASE) % BASE;
}
