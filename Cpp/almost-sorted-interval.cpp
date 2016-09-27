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
#define N 1000010

int n, a[N], len[N], righ[N], p[N], t[N], top;
vector<ii> Q;
ll res;

void update(int i, int val) {
    for(i; i <= n; i += i & (-i)) t[i] += val;
}

int get(int i) {
    int s = 0;
    for(i; i; i -= i & (-i)) s += t[i];
    return s;
}

void solve() {
    p[0] = n+1; top = 0;
    Rep(i, n, 1) {
        while (top && a[i] < a[p[top]]) top--;
        len[i] = p[top] - i; p[++top] = i;
        Q.pb(ii(len[i] + i, i));
    }
    sort(all(Q));
    p[0] = 0; top = 0;
    For(i, 1, n) {
        while (top && a[i] > a[p[top]]) top--;
        righ[i] = p[top] + 1; p[++top] = i;
    }
    int j = sz(Q);
    Rep(i, n, 1) {
        while (j > 0 && Q[j-1].fi >= i+1) {
            j--; update(Q[j].se, 1);
        }
        res += get(i) - get(righ[i] - 1);
    }
    cout << res;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", &a[i]);
    solve();
}




