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
#define bit(x, i) ( (x >> (i - 1)) & 1 )
#define onbit(x, i) ( x | (1 << (i-1) ) )
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 51
#define M 6
#define BASE 1000000007

int ntest, m, n, f[2][33][33][33][2];
char s[N][N];

void chuyen(int &c1, int &c2) {
    c1 = offbit(c1, n); c1 <<= 1;
    c2 >>= 1;
}

void add(int &x, int &a) {
    x += a;
    if (x >= BASE) x %= BASE;
}

bool canplace(int i, int j, int doc, int ngang, int c1, int c2) {
    if (ngang) return false;
    if (bit(doc, j) || bit(c1, j) || bit(c2, j)) return false;
    return true;
}

void solve() {
    reset(f, 0);
    int t = 1;
    f[0][0][0][0][0] = 1;
    int tt = two(n) - 1;
    int doc1, c3, c4, ngang1, ok1;
    For(i, 1, m) For(j, 1, n) {
        t = 1 - t;
        reset(f[1-t], 0);
        For(doc, 0, tt) For(c1, 0, tt) For(c2, 0, tt) For(ngang, 0, 1) if (f[t][doc][c1][c2][ngang] > 0) {
            if (s[i][j] == '#') {
                doc1 = offbit(doc, j);
                c3 = c1; c4 = c2;
                if (j == 1) chuyen(c3, c4);
                c3 = offbit(c3, j);
                c4 = offbit(c4, j);
                ngang1 = 0;
                add(f[1-t][doc1][c3][c4][ngang1], f[t][doc][c1][c2][ngang]);
            } else {
                doc1 = doc; // khong dat
                c3 = c1; c4 = c2; ngang1 = ngang;
                if (j == 1) {
                    ngang1 = 0; chuyen(c3, c4);
                }
                add(f[1-t][doc1][c3][c4][ngang1], f[t][doc][c1][c2][ngang]);
                // co dat
                doc1 = doc;
                c3 = c1; c4 = c2; ngang1 = ngang;
                if (j == 1) {
                    ngang1 = 0; chuyen(c3, c4);
                }
                if (canplace(i, j, doc1, ngang1, c3, c4)) {
                    doc1 = onbit(doc1, j); ngang1 = 1;
                    c3 = onbit(c3, j); c4 = onbit(c4, j);
                    add(f[1-t][doc1][c3][c4][ngang1], f[t][doc][c1][c2][ngang]);
                }
            }
        }
    }
    t = 1 - t;
    int res = 0;
    For(doc, 0, tt)
	For(c1, 0, tt)
	For(c2, 0, tt)
    For(ngang, 0, 1) {
        add(res, f[t][doc][c1][c2][ngang]);
    }
    res = res - 1;
    if (res < 0) res += BASE;
    printf("%d\n", res);
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d\n", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d", &m, &n);
        For(i, 1, m) scanf("%s\n", s[i]+1);
        solve();
    }
}
