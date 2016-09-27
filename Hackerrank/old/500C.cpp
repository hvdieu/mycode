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
#define N 1010

int n, b[N], pos[N], m;
ii a[N];

bool cmp(ii a, ii b) {
    return pos[a.se] < pos[b.se];
}

void solve() {
    For(i, 1, n) {
        pos[i] = m + 1;
        a[i].se = i;
    }
    Rep(i, m, 1) pos[b[i]] = i;
    sort(a+1, a+n+1, cmp);
    ll res = 0;
    For(i, 1, m) {
        ll sum = 0;
        For(j, 1, n) {
        	
            if (a[j].se == b[i]) {
                res += sum;
                Rep(k, j, 2) swap(a[k], a[k-1]);
                break;
            }
            sum += a[j].fi;
        }
    }
    cout << res;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> m;
    For(i, 1, n) cin >> a[i].fi;
    For(i, 1, m) {
        int x; cin >> x; b[i] = x;
    }
    solve();
}




