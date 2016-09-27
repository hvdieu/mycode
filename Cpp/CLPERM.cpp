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
#define N 500010

int n, k, a[N], f[10010];
ll res;
bool dd[10010];

void sub1() {
    reset(f, 0);
    f[0] = 1;
    int sum = 0; For(i, 1, n) if (dd[i]) sum += i;
    For(i, 1, n) if (dd[i])
    Rep(s, sum, i) if (f[s - i]) f[s] = 1;
    For(i, 1, sum+1) if (!f[i]) {
        res = i; return;
    }
}

void sub2() {
    res = (ll(n) * (n+1)) / 2 + 1;
}

ll tong(ll u, ll v) {
    if (u > v) return 0;
    ll len = (v - u + 1);
    return ((u + v) * len) / 2;
}

void sub3() {
    sort(a+1, a+k+1);
    a[0] = 0;
    ll sum = 0, s = 0;
    For(i, 1, k) {
    	s += a[i];
        sum += tong(a[i-1]+1, a[i]-1);
        if (sum < a[i]) {
            res = a[i]; return;
        }
    }
    res = tong(1, n) - s + 1;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    int ntest;
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d", &n, &k);
        reset(dd, true);
        For(i, 1, k) {
            scanf("%d", &a[i]);
            if (n <= 100) dd[a[i]] = false;
        }
        if (k == 0) sub2();
        else if (n <= 100) sub1();
        else
        sub3();
        //cout << res << ' ';
        if (res % 2) cout << "Chef"; else cout << "Mom"; cout << endl;
    }
}




