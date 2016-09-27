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
#define N 100010

int n;
vector<int> ke[N];
int uu[N], vv[N], kk[N], cha[N];
int MAX;
double chance, res;

void dfs(int u, int len) {
    MAX = max(MAX, len);
    FOR(v, ke[u]) if (!cha[*v]) {
        cha[*v] = u;
        dfs(*v, len+1);
    }
}

void sinh(int i) {
    if (i == n) {
        For(j, 1, n) cha[j] = 0;
        MAX = 0; cha[1] = 1;
        dfs(1, 0);
        res = res + chance * MAX;
        return;
    }
    chance = chance * double(kk[i]) / 100;
    ke[uu[i]].pb(vv[i]);
    ke[vv[i]].pb(uu[i]);
    sinh(i+1);
    chance = chance / (double(kk[i]) / 100) * double(100 - kk[i]) / 100;
    ke[uu[i]].pop_back();
    ke[vv[i]].pop_back();
    sinh(i+1);
    chance = chance / (double(100 - kk[i]) / 100);
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n-1) scanf("%d%d%d", uu+i, vv+i, kk+i);
    chance = 1;
    sinh(1);
    printf("%.4lf", res);
}


