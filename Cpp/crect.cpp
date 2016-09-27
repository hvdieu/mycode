#include <bits/stdc++.h>
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
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 501

int s[N][N], m, n, S, a[N];
ll res;

int sum(int i, int j, int u, int v) {
    return s[u][v] - s[u][j-1] - s[i-1][v] + s[i-1][j-1];
}

void sub1() {
    For(i, 1, m) For(j, 1, n) For(u, 1, i) For(v, 1, j)
    if (sum(u, v, i, j) <= S) res++;
    cout << res;
}

void sub2() {
    For(l, 1, n) For(r, l, n) {
        int j = 1, ss = 0;
        For(i, 1, m) {
            a[i] = sum(i, l, i, r);
            ss += a[i];
            while (ss > S) {
                ss -= a[j]; j++;
            }
            res += i-j+1;
        }
    }
    cout << res;
}

int main() {
    freopen("crect.in","r",stdin);
    freopen("crect.out","w",stdout);
    scanf("%d %d %d", &m, &n, &S);
    For(i, 1, m) For(j, 1, n) {
        int x; scanf("%d", &x);
        s[i][j] = s[i][j-1] + s[i-1][j] - s[i-1][j-1] + x;
    }
    if (m <= 50 && n <= 50) sub1(); else
    sub2();
}
