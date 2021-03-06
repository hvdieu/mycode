#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 110

int a[N][N], n, ntest, f[N][N], res;

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        For(i, 1, n) For(j, 1, i) scanf("%d", &a[i][j]);
        reset(f, 0);
        f[1][1] = a[1][1];
        For(i, 1, n-1) For(j, 1, n) {
            f[i+1][j] = max(f[i+1][j], f[i][j] + a[i+1][j]);
            f[i+1][j+1] = max(f[i+1][j+1], f[i][j] + a[i+1][j+1]);
        }
        res = 0;
        For(j, 1, n) res = max(res, f[n][j]);
        cout << res << endl;
    }
}




