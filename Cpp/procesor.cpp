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

int n, p[N], t[N], vt[N], m, tt[N];
ll res;

bool cmp(int i, int j) {
    if (p[i] != p[j]) return p[i] > p[j];
    return t[i] > t[j];
}

void update(int i) {
    while (i <= n) {
        tt[i]++;
        i += i & (-i);
    }
}

int get(int i) {
    int s = 0;
    while (i) {
        s += tt[i];
        i -= i & (-i);
    }
    return s;
}

int sum(int i, int j) {
    return get(j+1) - get(i);
}

int main() {
    freopen("procesor.in","r",stdin);
    freopen("procesor.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d %d", &t[i], &p[i]);
        if (t[i] <= n) vt[++m] = i;
    }
    sort(vt+1, vt+1+m, cmp);
    For(i, 1, m) {
        int j = vt[i];
        int d = 0, c = t[j]-1, mid, ans = -1;
        if (get(t[j]) != t[j])
        while (d <= c) {
            mid = (d + c) / 2;
            int y = sum(mid, t[j] - 1);
            if (y != (t[j]-mid)) {
                ans = mid; d = mid + 1;
            } else c = mid - 1;
        }
        if (ans == -1) res += p[j];
        else update(ans+1);
    }
    cout << res;
}
