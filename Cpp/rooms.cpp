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
#define N 1001

struct pe {
    int s, f;
};

pe a[N];
int n, st[N], top;

bool cmp(pe A, pe B) {
    if (A.s != B.s) return A.s < B.s;
    return A.f < B.f;
}

void solve() {
    sort(a+1, a+n+1, cmp);
    top = 0;
    For(i, 1, n) {
        int u = 0;
        For(j, 1, top) if (a[i].s >= st[j]) {
            if (!u || st[j] < st[u]) u = j;
        }
        if (!u) st[++top] = a[i].f;
        else st[u] = a[i].f;
    }
    cout << top;
}

int main() {
    freopen("rooms.inp","r",stdin);
    freopen("rooms.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d %d", &a[i].s, &a[i].f);
    solve();
}
