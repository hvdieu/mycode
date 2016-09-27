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

int n,m,cha[N],lab[N],low[N],num[N],timer,st[N],top,cnt;
vector<int> ke[N];
bool fr[N];

void dfs(int u) {

}

void solve() {
    For(i,1,n) if (!cha[i]) {
        cha[i] = i; top = 0;
        dfs(i);
    }
}

int main() {
    freopen("khistory.inp","r",stdin);
    freopen("khistory.out","w",stdout);
    scanf("%d%d",&n,&m);
    For(i,1,m) {
        int u,v;
        scanf("%d%d",&u,&v);
        ke[u].pb(v); ke[v].pb(u);
    }
    solve();
}
