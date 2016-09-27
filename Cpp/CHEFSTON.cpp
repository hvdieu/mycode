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
#define N 100010

int ntest, n, k, a[N], b[N];
ll res;

int main() {
    freopen("input.txt","r",stdin);
   // freopen("","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d %d", &n, &k);
        res = 0;
        For(i, 1, n) scanf("%d", a+i);
        For(i, 1, n) scanf("%d", b+i);
        For(i, 1, n) {
            ll x = k / a[i];
            res = max(res, x * b[i]);
        }
        cout << res << endl;
    }
}




