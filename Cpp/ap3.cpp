

#include <functional>
#include <algorithm>
#include <iostream>
#include <cstdlib>
#include <utility>
#include <cstring>
#include <numeric>
#include <sstream>
#include <climits>
#include <cstdio>
#include <string>
#include <vector>
#include <bitset>
#include <stack>
#include <queue>
#include <cmath>
#include <ctime>
#include <list>
#include <set>
#include <map>

#define lfo(i, a, b) for(int i = a, _b = b; i <= _b; ++i)
#define rfo(i, a, b) for(int i = a, _b = b; i >= _b; --i)
#define rel(i, a, b) for(int i = a, _b = b; i < _b; ++i)
#define rer(i, a, b) for(int i = a, _b = b; i > _b; --i)
#define fore(i, c) for(typeof((c).begin()) i = (c).begin(); i != (c).end(); ++i)
#define rofe(i, c) for(typeof((c).rbegin()) i = (c).rbegin(); i != (c).rend(); ++i)
#define reset(a, k) memset(a, k, sizeof(a))
#define all(c) (c).begin(), (c).end()
#define length(c) int((c).length())
#define size(c) int((c).size())
#define lob lower_bound
#define upb upper_bound
#define puf push_front
#define pof pop_front
#define pub push_back
#define pob pop_back
#define ins insert
#define ers erase
#define mmap multimap
#define mset multiset
#define mp make_pair
#define st1 first
#define nd2 second

#define _min(a, b) ((a) < (b) ? (a) : (b))
#define _max(a, b) ((a) < (b) ? (b) : (a))
#define _abs(a) ((a) < 0 ? -(a) : (a))

using namespace std;

#define maxN 111

typedef double dbl;

typedef long double ldbl;

typedef long long ll;

typedef unsigned int uint;

typedef unsigned long long ull;

typedef pair <int, int> prii;

typedef pair <ll, int> prli;

typedef pair <dbl, int> prfi;

typedef vector <int> vi;

const dbl pi = acos(-1);

const dbl eps = 1e-6;

int _rand() {
	return rand() % 1000 * 1000000 + rand() % 1000 * 1000 + rand() % 1000;
}

inline int Bit(int a, int k) {
	return (a >> k) & 1;
}

inline int max(int a, int b, int c) {
	return a > b ? (a > c ? a : c) : (b > c ? b : c);
}

inline int min(int a, int b, int c) {
	return a < b ? (a < c ? a : c) : (b < c ? b : c);
}

vi e[maxN], g[maxN];

int m, n, de[maxN], dg[maxN];

void refresh() {
    lfo(i, 1, m) e[i].clear();
    lfo(i, 1, n) g[i].clear();
    reset(de, 0), reset(dg, 0);
}

void inp() {
    int u, v;
    scanf("%d", &n);
    rel(i, 1, n) {
        scanf("%d%d", &u, &v);
        g[u].pub(v), ++dg[u];
        g[v].pub(u), ++dg[v];
    }
    scanf("%d", &m);
    rel(i, 1, m) {
        scanf("%d%d", &u, &v);
        e[u].pub(v), ++de[u];
        e[v].pub(u), ++de[v];
    }
}

int q[maxN], front, back;

int cl[maxN], tr[maxN], c[maxN][maxN];

int Xend, Yend, mf, X[maxN], Y[maxN];

int FindPath(int s, int t, int ps, int pt) {
    rel(i, 1, back) cl[q[i]] = 0; front = back = 1;
    fore(it, e[s]) if (*it != ps) {
        int u = *it; if (X[u]) continue;
        tr[u] = 0, cl[u] = 1;
        q[back++] = u;
    }
    while (front != back) {
        int u = q[front++];
        fore(it, g[t]) if (*it != pt) {
            int v = *it; if (c[u][v] != 1 || v == X[u]) continue;
            if (!Y[v]) {
                Xend = u, Yend = v;
                return 1;
            } else {
                int w = Y[v];
                if (!cl[w]) {
                    tr[w] = u, cl[w] = 1;
                    q[back++] = w;
                }
            }
        }
    }
    return 0;
}

void IncFlow() {
    ++mf;
    int u = Xend, v = Yend;
    while (u) {
        int _v = X[u];
        X[u] = v, Y[v] = u;
        u = tr[u], v = _v;
    }
}

int match(int u, int v, int pu, int pv) {
    if (~c[u][v]) return c[u][v];
    if (de[u] > dg[v])
        return c[u][v] = 0;
    int num = de[u] - (pu != 0);
    fore(i, e[u]) fore(j, g[v])
        if (*i != pu && *j != pv) match(*i, *j, u, v);
    reset(X, 0), reset(Y, 0);
    mf = 0;
    while (FindPath(u, v, pu, pv))
        IncFlow();
    return c[u][v] = (mf == num);
}

void solve() {
    lfo(i, 1, n) {
        reset(c, -1);
        if (match(1, i, 0, 0)) {
            printf("YES\n");
            return;
        }
    }
    printf("NO\n");
}

int main() {
#ifndef ONLINE_JUDGE
    freopen("input.txt", "r", stdin);
    freopen("ap.out", "w", stdout);
#endif // ONLINE_JUDGE
    srand(time(NULL));
    int T; scanf("%d", &T);
    lfo(t, 1, T) {
        printf("Case #%d: ", t);
        refresh();
        inp();
        solve();
    }
    return 0;
}

