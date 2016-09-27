#include <bits/stdc++.h>
#define LL long long
#define ULL unsigned long long
#define REP(i,b) for(int i=0;i<b;i++)
#define FOR(i,a,b) for(int i=a;i<=b;i++)
#define FO(i,a,b) for(int i=a;i<b;i++)
#define FORD(i,a,b) for(int i=a;i>=b;i--)
#define FOD(i,a,b) for(int i=a;i>b;i--)
#define FORV(i,a) for(typeof(a.begin()) i = a.begin(); i != a.end(); i++)
#define x first
#define y second
#define pb push_back
#define mp make_pair
#define debug cout << "YES" << endl

using namespace std;

typedef pair<int,int>II;

const long double PI = 2*acos(0.0);
const long double eps = 1e-15;
const int infi = 1e9;
const LL Linfi = (LL) 1e18;
const LL MOD = 1000000007;
const int c1 = 31;
const int c2 = 37;
#define maxn 100005


int bit[maxn+5], a[maxn];
int n, m, time_discover = 0;
int ans[maxn], cost[maxn], time_in[maxn], time_out[maxn];
vector<int> adj[maxn];

void DFS(int u){
    time_in[u] = ++time_discover; //cout << u << endl;
    FO(i,0,adj[u].size()){
        int v = adj[u][i];
        DFS(v);
    }
    time_out[u] = time_discover;
}

void solve(){
    DFS(1);
    FOR(i,1,n){
        int in = time_in[i];
        a[in] = cost[i];
    }
    FOR(i,1,n){
        int in = time_in[i], out = time_out[i];
        FOR(j,in,out) if(a[j] < cost[i]) ans[i]++;
    }
    LL res = 0;
	FOR(i,1,n) res += 1LL*ans[i]*(ans[i]-1)/2, cout << ans[i] << ' ';
	cout << endl;
	cout << res << endl;
	//FOR(iq,1,n) printf("%d ", ans[iq]);
}

int main(){
    ios::sync_with_stdio(false);
#ifndef ONLINE_JUDGE
    freopen("input.txt","r",stdin);
    freopen("test.out","w",stdout);
#endif
    cin >> n;
    cin >> cost[1];
    FOR(i,2,n){
        int x;
        cin >> x >> cost[i];
        adj[x].pb(i);
    }
    solve();

    return 0;
}


