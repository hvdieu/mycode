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
#define lef first
#define righ second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define two(i) (ll(1) << i)
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 100010
#define inf 100000000

int n, a[N], lef[N], righ[N], m, g[N], top, p[N];
ii b[N];
int vmax, f[N][20];

void sub1() {
    while (m) {
        m--;
        int kind, u, v;
        scanf("%d%d%d", &kind, &u, &v);
        if (kind == 1) a[u] = v;
        else {
            g[v+1] = inf;
            Rep(i, v, u) g[i] = min(g[i+1], a[i]);
            int mi = a[u];
            int flag = 0;
            For(i, u+1, v-1) {
                if (a[i] > mi && a[i] > g[i+1]) {
                    flag = true; break;
                }
                mi = min(mi, a[i]);
            }
            cout << flag << endl;
        }
    }
}

void init() {
    top = 0; p[0] = 0;
    For(i, 1, n) {
        while (top && a[i] <= a[p[top]]) top--;
        b[i].lef = p[top]; p[++top] = i;
    }
    top = 0; p[0] = n+1;
    Rep(i, n, 1) {
        while (top && a[i] <= a[p[top]]) top--;
        b[i].righ = p[top]; p[++top] = i;
    }
    sort(b+1, b+n+1);
    vmax = trunc(log(n) / log(2));
    For(i, 1, n) f[i][0] = b[i].righ;
    For(j, 1, vmax) For(i, 1, n-two(j)+1)
    f[i][j] = min(f[i][j-1], f[i + two(j-1)][j-1]);
}

int get(int i, int j) {
    int k = trunc(log(j-i+1) / log(2));
    return min(f[i][k], f[j - two(k) + 1][k]);
}

int Find(int key) {
    int d = 1, c = n, mid, ans = -1;

}

void Query(int u, int v) {
    int x = Find(u);
}

void sub2() {
    while (m) {
        m--; int kind, u, v;
        scanf("%d%d%d", &kind, &u, &v);
        if (kind == 1) {
            a[u] = v; init();
        } else Query(u, v);
    }
}

int main() {
    freopen("seqb3.inp","r",stdin);
    freopen("seqb3.out","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, n) scanf("%d", &a[i]);
    if (n <= 1000 && m <= 1000) sub1();
   // else sub2();
}
