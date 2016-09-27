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
#define N 30010

int n, a[N], t;
bool was[N];
int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> t;
    For(i, 1, n-1) cin >> a[i];
    int u = 1; was[1] = true;
    while (u < n) {
        u = u + a[u];
        was[u] = true;
    }
    if (was[t]) cout << "YES"; else cout << "NO";
}




