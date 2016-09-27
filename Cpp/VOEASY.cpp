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
#define two(x) (1 << (x - 1))
#define bit(x, i) ((x >> (i - 1)) & 1)
#define onbit(x, i) (x | (1 << (i - 1)))
#define N 11

struct oper {
    int u[N], v[N], kind[N];
};

int n, a[N], m, k, b[N];
oper c[110];
int dd[2048], f[2048];

void input() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d%d", &n, &m, &k);
    For(i, 1, n) scanf("%d", &a[i]);
    For(i, 1, m) {
        int u, v, kind;
        string s;
        For(j, 1, n) {
            cin >> u >> s >> v;
            if (s == "and") kind = 1;
            else if (s == "or") kind = 2;
            else kind = 3;
            c[i].u[j] = u; c[i].v[j] = v; c[i].kind[j] = kind;
        }
    }
}

int Do(int x, int t) {
    int y = 0;
        For(j, 1, n) {
            int u = c[t].u[j], v = c[t].v[j], kind = c[t].kind[j];
            int p;
            if (kind == 1) p = bit(x, u) & bit(x, v);
            else if (kind == 2) p = bit(x, u) | bit(x, v);
            else p = bit(x, u) ^ bit(x, v);
            if (p) y += two(j);
        }
        return y;
}

int cycle(int x, int k) {
    reset(dd, 0xff);
    dd[x] = 1; f[1] = x;
    int first = -1, last = -1, len;
    int t = 0;
    int ss = k / m;
    k = k - ss * m;
    int cnt = 0;
    For(i, 2, ss+1) {
        if (t > m) t = 1;
        cnt++;
        For(t, 1, m) x = Do(x, t);
        f[i] = x;
        if (dd[x] != -1) {
            first = dd[x], last = i - 1;
            break;
        } else dd[x] = i;
    }
    if (first > 0) {
        ss -= last;
        len = last - first + 1;
        int kk = ss / len;
        if (ss % len == 0) kk--;
        ss = ss - kk * len;
        x = f[first + ss - 1];
    }
    For(i, 1, k) x = Do(x, i);
    return x;
}

void solve() {
    For(i, 1, 31) {
        int tt = 0;
        For(j, 1, n) if (bit(a[j], i)) tt += two(j);
	    tt = cycle(tt, k);
        For(j, 1, n)
		if (bit(tt, j)) b[j] += two(i);
    }
    For(i, 1, n) cout << b[i] << ' ';
}

int main() {
    input();
    solve();
}




