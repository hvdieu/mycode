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
#define pos first
#define cost second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define two(i) (ll(1) << i)
#define N 50010
#define inf 1000000000

int tank, cur, n, finish, vmax, f[N][20], now, next[N], p[N], top;
ii a[N];
ll res;

void init() {
    p[0] = n+1; top = 0;
    Rep(i, n, 1) {
        while (top && a[i].cost <= a[p[top]].cost) top--;
        next[i] = p[top];
        p[++top] = i;
    }
}

void fill_tank(int dis, int cost){
    res += ll(dis) * cost;
}

int main() {
    freopen("fuel.inp","r",stdin);
    freopen("fuel.out","w",stdout);
    scanf("%d%d%d%d", &n, &tank, &cur, &finish);
    For(i, 1, n) scanf("%d%d", &a[i].pos, &a[i].cost);
    a[++n] = ii(0, inf);
    sort(a+1, a+n+1);
    if (a[n].pos != finish) a[++n] = ii(finish, 0);
  /*  vmax = trunc(log(n) / log(2));
    For(i, 1, n) f[i][0] = a[i].cost;
    For(j, 1, vmax) For(i, 1, n - two(i) + 1)
    f[i][j] = min(f[i][j-1], f[i + two(j-1)][j-1]); */
    int i = 1;
    init();
    while (i < n) {
        if (a[i+1].pos - a[i].pos > tank) {
            cout << -1; return 0;
        }
        if (finish - a[i].pos <= cur) break;
        int j = next[i];
        int dis = a[j].pos - a[i].pos;
        if (dis <= cur) {
            cur -= a[j].pos - a[i].pos;
            i = j;
        } else if (dis <= tank) {
            fill_tank(dis - cur, a[i].cost);
            cur = 0; i = j;
        } else {
            fill_tank(tank - cur, a[i].cost);
            cur = tank - (a[i+1].pos - a[i].pos); i++;
        }
    }
    cout << res;
}
