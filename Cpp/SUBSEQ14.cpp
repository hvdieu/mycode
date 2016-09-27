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
#define N 100010
#define BASE 20011

int n, a[N], t[50001], res, s[N], k, kq, ma, mb;

inline void update(int i, int val) {
    while (i <= 20001) {
        t[i] = max(t[i],val);
        i += i & (-i);
    }
}

inline int get(int i) {
    int s = 0;
    while (i) {
        s = max(s, t[i]);
        i -= i & (-i);
    }
    return s;
}

inline void solve() {
    For(i, 0, 20001) t[i] = 0;
    Rep(i, n, 1) {
        int x = get(a[i]+1) + 1;
        kq = max(kq, x);
        update(a[i]+1, x);
    }
    cout << kq << endl;
    cout << res;
}

int main() {
    freopen("subseq14.inp","r",stdin);
    //freopen("subseq14.out","w",stdout);
    scanf("%d %d",&n,&k);
    t[0]++;
    mb = 10000000;
    For(i, 1, n) {
        scanf("%d", &a[i]);
        mb = min(mb, a[i]);
        ma = max(ma, a[i]);
       // if (!a[i]) cout << i << ' ';
        s[i] = (s[i-1] + a[i]);
        if (s[i] >= k) s[i] %= k;
        res += t[s[i]];
        if (res >= BASE) res -= BASE;
        t[s[i]]++;
        if (t[s[i]] >= BASE) t[s[i]] -= BASE;
    }
    solve();
}
