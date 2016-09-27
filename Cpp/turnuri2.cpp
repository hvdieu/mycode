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
#define N 1000010

int n, h[N], t[N], l[N], r[N], maxl[N], maxr[N], f[N][20], vmax, p[N], top;

int get(int i, int j) {
    if (!i) i++; if (j > n) j--;
    int k = trunc(log(j-i+1) / log(2));
    return max(f[i][k], f[j - (1 << k) + 1][k]);
}

int main() {
    freopen("turnuri2.in","r",stdin);
    freopen("turnuri2.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d %d", &h[i], &t[i]);
   // vmax = trunc(log(n) / log(2));
   // For(i, 1, n) f[i][0] = t[i];
   // For(j, 1, vmax) For(i, 1, n - (1 << j) + 1) f[i][j] = max(f[i][j-1], f[i + (1 << (j-1))][j-1]);
    p[0] = 0; p[1] = 1; l[1] = 1; top = 1; maxl[1] = t[1];
    For(i, 2, n) {
        maxl[i] = t[i];
        if (h[i] < h[i-1]) {
            l[i] = i-1; maxl[i] = max(t[i], t[i-1]);
            p[++top] = i;
        } else {
            while (top && h[p[top]] <= h[i]) {
                maxl[i] = max(maxl[i], maxl[p[top]]);
                top--;
            }
            maxl[i] = max(maxl[i], t[p[top]]);
            l[i] = p[top]; p[++top] = i;
        }
    }

    p[0] = n+1; p[1] = n; r[n] = n; maxr[n] = t[n]; top = 1;
    Rep(i, n-1, 1) {
        maxr[i] = t[i];
        if (h[i] < h[i+1]) {
            r[i] = i+1; maxr[i] = max(t[i], t[i+1]);
            p[++top] = i;
        } else {
            while (top && h[p[top]] <= h[i]) {
                maxr[i] = max(maxr[i], maxr[p[top]]);
                top--;
            }
            maxr[i] = max(maxr[i], t[p[top]]);
            r[i] = p[top]; p[++top] = i;
        }
    }
    For(i, 1, n) printf("%d\n", max(maxl[i], maxr[i]));
    //For(i, 1, n) if (max(maxl[i], maxr[i]) - get(l[i], r[i])) cout << i << ' ' << max(maxl[i], maxr[i]) - get(l[i], r[i]) << endl;
}
