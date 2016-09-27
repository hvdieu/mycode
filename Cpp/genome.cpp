#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> ii;
typedef pair<unsigned long long, int> lli;
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
#define N 30001

int n, k, id[26];
char s[N][31];
ull h[N][31], mu[31];
vector<lli> Q;

void init() {
    id[0] = 0; id[int('G') - int('A')] = 1; id[int('T') - int('A')] = 2; id[int('C') - int('A')] = 3;
    mu[0] = 1; For(i, 1, 30) mu[i] = mu[i-1] * 4;
    For(i, 1, n) For(j, 1, 30) h[i][j] = h[i][j-1] * 4 + id[int(s[i][j]) - int('A')];
}

ull get(int t, int i, int j) {
    return h[t][j] - h[t][i-1] * mu[j-i+1];
}

bool cmp(lli a, lli b) {
    if (a.fi != b.fi) return a.fi < b.fi;
    return a.se < b.se;
}

bool check(int len) {
    Q.clear();
    For(i, 1, n) For(j, 1, 30 - len + 1) Q.pb(lli(get(i, j, j + len - 1), i));
    sort(Q.begin(), Q.end(), cmp);
    int dem = 1;
    For(i, 1, sz(Q)-1) {
        if (Q[i].fi != Q[i-1].fi) dem = 1;
        else if (Q[i].se != Q[i-1].se) dem++;
        if (dem >= k) return true;
    }
    return false;
}

int main() {
    freopen("genome.inp","r",stdin);
    freopen("genome.out","w",stdout);
    scanf("%d%d\n", &n, &k);
    For(i, 1, n) scanf("%s\n", (s[i]+1));
    if (k == 1) cout << 30;
    else {
        init();
        int d = 1, c = 30, ans = -1, mid;
        while (d <= c) {
            mid = (d + c) / 2;
            if (check(mid)) {
                ans = mid; d = mid + 1;
            } else c = mid - 1;
        }
        cout << ans;
    }
}
