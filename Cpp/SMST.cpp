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
#define N 210

int n,m,dem,root[N],cha[N],w[N];
bool dd[N];
ll res;
vector<int> q;

int getroot(int u) {
    if (u != root[u]) root[u] = getroot(root[u]);
    return root[u];
}

void reroot(int v) {
    q.clear();
    while (v) {
        q.pb(v);
        v = cha[v];
    }
    Rep(i,sz(q)-1,1) {
        cha[q[i]] = q[i-1];
        w[q[i]] = w[q[i-1]];
    }
}

int lca(int u,int v) {
            memset(dd,true,sizeof(dd));
            int pp = 0;
            while (1) {
                if (u && !dd[u]) {
                    pp = u; break;
                } else if (u) {
                    dd[u] = false; u = cha[u];
                }
                if (v && !dd[v]) {
                    pp = v; break;
                } else if (v) {
                    dd[v] = false; v = cha[v];
                }
            }
            return pp;
}

int main() {
    freopen("smst.inp","r",stdin);
    freopen("smst.out","w",stdout);
    scanf("%d%d",&n,&m);
    For(i,1,n) root[i] = i;
    dem = n-1;
    while (m) {
        m--;
        int u,v,l;
        scanf("%d%d%d",&u,&v,&l);
        int r1 = getroot(u), r2 = getroot(v);
        if (r1 != r2) {
            dem--;
            root[r1] = root[r2];
            res += l;
            reroot(v);
            cha[v] = u; w[v] = l;
        } else {

            int uu = u, vv = v; int pp = lca(u,v);
            int temp = -1000000001;
            int j = 0;
            while (u != pp) {
                if (w[u] > temp) {
                    temp = w[u]; j = u;
                }
                u = cha[u];
            }
            while (v != pp) {
                if (w[v] > temp) {
                    temp = w[v]; j = v;
                }
                v = cha[v];
            }
            if (temp > l) {
                res = res - temp + l;
                cha[j] = 0;
                u = uu; v = vv;
                reroot(v);
                cha[v] = u;
                w[v] = l;
            }
        }
        if (dem) printf("123456789\n");
        else printf("%lld\n",res);
    }
}
