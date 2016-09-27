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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()

const int p[4] = { 2, 3 ,5 ,7 };

ull A, B, bound, lo, hi , mu[20], pos[6000][10], res;
vector<int> Q;
ull f[19][6000];
bool check[19][6000];

void gen(int i, ll x) {
    if (x > bound) return;
    if (i > 3) {
        Q.pb(x); return;
    }
    ll power = 1;
    while (1) {
        if (x * power > bound) break;
        gen(i+1, x * power);
        power *= p[i];
    }
}

ull cal(int i, ull x, int j) {
    ull left = x * mu[i], right = (x + 1) * mu[i] - 1;
    if (left > hi || right < lo) return 0;
    if (i == 0) return x && j == 0;
    if (lo <= left && right <= hi && check[i][j]) return f[i][j];
    ll res = 0;
    if (!x) res += cal(i-1, x, j);
    For(ch, 1, 9) if (Q[j] % ch == 0) res += cal(i-1, x * 10 + ch, pos[j][ch]);
    if (lo <= left && right <= hi) {
        check[i][j] = true; f[i][j] = res;
    }
    return res;
}

int main() {
    //freopen("QVSICK.INP","r",stdin);
   // freopen("QVSICK.OUT","w",stdout);
    cin >> A >> B;
    bound = trunc(sqrt(B));
    gen(0, 1);
    sort( all(Q) );
   // For(i, 0, sz(Q)-1 ) cout << Q[i] << ' ';
    mu[0] = 1; For(i, 1, 19) mu[i] = mu[i-1] * 10;
    For( i, 0, sz(Q)-1 ) {
        int x = Q[i];
        lo = ceil((long double)A / x);
        hi = floor( (long double)B / x );
        For(j , 1, 9) if (x % j == 0) pos[i][j] = lower_bound(all(Q), x / j) - Q.begin();
        res += cal(18, 0, i);
    }
    cout << res;
}



