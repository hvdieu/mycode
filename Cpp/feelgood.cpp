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
#define N 100001

int n, a[N], st[N], top, l[N], r[N];
ll s[N];

void solve() {
    top = 1; st[0] = 0; st[1] = 1; l[1] = 1;
    For(i, 2, n) {
        if (a[i] > a[i-1]) {
            l[i] = 1; st[++top] = i;
        } else {
            while (top && a[st[top]] >= a[i]) top--;
            l[i] = i - st[top]; st[++top] = i;
        }
    }

    top = 1; st[0] = n+1; st[1] = n; r[1] = 1;
    Rep(i, n-1, 1) {
        if (a[i] > a[i+1]) {
            r[i] = 1; st[++top] = i;
        } else {
            while (top && a[st[top]] >= a[i]) top--;
            r[i] = st[top] - i; st[++top] = i;
        }
    }

    ll res = 0;
    For(i, 1, n) {
        int u = i - l[i] + 1, v = i + r[i] - 1;
        res = max(res, ll(a[i]) * (s[v] - s[u-1]));
    }
    cout << res;
}

int main() {
    freopen("feelgood.inp","r",stdin);
    freopen("feelgood.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i]); s[i] = s[i-1] + a[i];
    }
    solve();
}
