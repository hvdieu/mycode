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

int n, ntest, G, a[N], sum, f[N*N];

string solve() {
    if (sum <= G) return "YES";
    int s = 0; reset(f, 0);
    f[0] = 1;
    For(i, 1, n) {
        Rep(S, min(s, G), 0) if (f[S]) f[S + a[i]] = 1;
        s += a[i];
    }
    For(i, 1, G) if (f[i] && sum - i <= G) return "YES";
    return "NO";
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        sum = 0;
        scanf("%d%d", &n, &G);
        For(i, 1, n) {
            scanf("%d", &a[i]);
            sum += a[i];
        }
        cout << solve() << endl;
    }
}




