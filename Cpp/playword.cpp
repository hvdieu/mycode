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
#define N 3010

int n, f[N][N], res;
char s[N];

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%s\n", s+1);
    n = strlen(s+1);
    For(i, 1, n) f[i][i] = 1;
    For(len, 2, n) For(i, 1, n-len+1) {
        int j = i + len - 1;
        f[i][j] = max(f[i][j-1], f[i+1][j]);
        if (s[i] == s[j]) f[i][j] = max(f[i][j], f[i+1][j-1] + 2);
    }
    For(i, 1, n-1) res = max(res, f[1][i] * f[i+1][n]);
    cout << res;
}




