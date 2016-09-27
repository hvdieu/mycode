#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))

const int M = 1e9 + 7;
const int N = 1e6 + 10;

int a[N], n;
ll s[N], f[N];
ll S[N]; // sum of s
ll g[N]; // s[j]*j
ll F[N];
ll ans;
ll sc[N], SC[N];
ll jsc[N], ssc[N];
ll h[N];

int sum(int n) {
    return n * (n+1) / 2;
}

int main() {
    //freopen("in.txt","r",stdin);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d", a+i);
    sc[0] = SC[0] = 1;
    For(i, 1, n) {
        s[i] = (s[i-1] + a[i]) % M;
        S[i] = (S[i-1] + s[i]) % M;
        sc[i] = SC[i-1];
        SC[i] = (SC[i-1] + sc[i]) % M;
        jsc[i] = (jsc[i-1] + sc[i]*i) % M;
        ssc[i] = (ssc[i-1] + s[i]*sc[i]) % M;
        g[i] = (g[i-1] + (((s[i]*i) % M) * sc[i]) % M) % M;
        ll tmp = F[i-1];
        tmp = (tmp - (s[i]*jsc[i-1]) % M + M) % M;
        tmp = (tmp - (ssc[i-1]*i) % M + M) % M;
        tmp = (tmp + (((s[i]*i) % M) * SC[i-1]) % M) % M;
        tmp = (tmp + g[i-1]) % M;
        f[i] = tmp;
        //f[i] = F[i-1] + s[i]*i*SC[i-1] - s[i]*jsc[i-1] - i*ssc[i-1] + g[i-1];
        F[i] = (F[i-1] + f[i]) % M;
        //For(j, 0, i-1) h[i] += h[j] + (s[i] - s[j]) * (i - j) * sc[j];
    }
   // For(i, 0, n) cout << f[i] << ' '; cout << "\n";
    //For(i, 0, n) cout << SC[i] << ' '; cout << "\n";
    cout << f[n];
}


