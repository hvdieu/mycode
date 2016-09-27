#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#include <queue>
#include <stack>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 100010
#define inf 100000000000000LL

struct node {
    int u,high;
    ll val;
    node(ll a,int b,int c) {
        val = a; u = b; high = c;
    }
};

bool operator > (const node &A, const node &B) {
    return A.val > B.val;
}

int n,m,X,h[N];
vector <int> ke[N],w[N];
priority_queue <node, vector<node>, greater<node> > heap;
map<int, ll> f[N];
map<int, ll>::iterator it;
ll res;

void solve() {
    f[1][X] = 0;
    heap.push(node(0,1,X));
    while (1) {
        if (heap.empty()) break;
        int u = heap.top().u, hi = heap.top().high;
        ll gt = heap.top().val;
        heap.pop();
        For(j,0,sz(ke[u])-1) {
            int v = ke[u][j], t = w[u][j];
            if (hi- t>= 0 && hi-t <= h[v]) {
                it = f[v].find(hi-t);
                if (it==f[v].end() || it->se > gt+t) {
                    f[v][hi-t] = gt + t;
                    heap.push(node(gt+t,v,hi-t));
                }
            } else if (hi-t < 0 && t <= h[u]) {
                it = f[v].find(0);
                if (it==f[v].end() || it->se > gt+t+t-hi) {
                    f[v][0] = gt+t+t-hi;
                    heap.push(node(gt+t+t-hi,v,0));
                }
            } else if (hi-t > h[v]) {
                it = f[v].find(h[v]);
                ll ts = gt+t+(hi-t-h[v]);
                if (it==f[v].end() || it->se > ts) {
                    f[v][h[v]] = ts;
                    heap.push(node(ts,v,h[v]));
                }
            }
        }
    }
    res = inf;
    while (!f[n].empty()) {
        it = f[n].begin();
       // printf("%d %lld\n",it->fi,it->se);
        res = min(res,it->se + h[n]-it->fi);
        f[n].erase(it);
    }
    if (res==inf) cout << -1;
        else cout << res;
}

int main() {
    freopen("ROBOT.INP","r",stdin);
    freopen("ROBOT.OUT","w",stdout);
    scanf("%d%d%d",&n,&m,&X);
    For(i,1,n) scanf("%d",&h[i]);
    For(i,1,m) {
        int u,v,t;
        scanf("%d%d%d",&u,&v,&t);
        ke[v].pb(u); w[v].pb(t);
        ke[u].pb(v); w[u].pb(t);
    }
    solve();
}


