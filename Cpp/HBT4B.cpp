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

int n;
ll a[N];
priority_queue<int, vector<int> > heap;

void solve() {
    sort(a+1, a+n+1);
    int x = 0;
    while (!heap.empty()) heap.pop();
    For(i, 1, n) {
        x++;
        if (a[i] != a[i+1]) {
            heap.push(x);
            x = 0;
        }
    }
    int res = 0;
    while (sz(heap) > 2) {
        int x[3], mi = n+1;
        For(i, 0, 2) {
            x[i] = heap.top(); heap.pop();
            mi = min(mi, x[i]);
        }
        res += mi;
        For(i, 0, 2) if (x[i] - mi) heap.push(x[i] - mi);
    }
    cout << res << endl;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    int ntest;
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        For(i, 1, n) scanf("%lld", &a[i]);
        solve();
    }
}




