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
#define N 510

int n, a[N], deg[N];
vector<int> kq;
priority_queue< ii, vector<ii> > heap;

bool check() {
    while (!heap.empty()) heap.pop();
    For(i, 1, n) heap.push(ii(deg[i], i));
    while (!heap.empty()) {
        int gt = heap.top().fi, u = heap.top().se;
        heap.pop();
        vector<int> q; q.clear();
        For(i, 1, gt) {
            if (heap.empty()) return false;
            int v = heap.top().se; heap.pop();
            if (!deg[v]) return false;
            deg[v]--; q.pb(v);
        }
        For(i, 0, sz(q)-1) {
            int v = q[i];
            heap.push(ii(deg[v], v));
        }
    }
    return true;
}

int main() {
    freopen("fcount.in","r",stdin);
    freopen("fcount.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n+1) scanf("%d", &a[i]);
    For(i, 1, n+1) {
        int m = 0;
        For(j, 1, n+1) if (i != j) deg[++m] = a[j];
        if (check()) kq.pb(i);
    }
    cout << sz(kq) << endl;
    For(i, 0, sz(kq)-1) cout << kq[i] << endl;
}
