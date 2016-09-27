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
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define N 100010

int n,m,q,x[N],y[N],type[N],p,stt[N],d[N][2][2],res[2][2],dd[2][2];
vector<int> ke[N];

bool cmp(int i,int j) {
    return type[i] < type[j];
}

void change(int u) {
    if (type[u] == 1) {
        For(t1,0,1) For(t2,0,1) {
            dd[t1][t2] = d[u][t1][t2];
            if (t1 != t2) res[t1][t2] -= d[u][t1][t2] + d[u][t2][t1];
            else res[t1][t2] -= 2 * d[u][t1][t2];
        }
        if (!stt[u]) {
            d[u][0][1] = 0;
            d[u][1][1] = dd[0][1];
            d[u][0][0] = 0;
            d[u][1][0] = dd[0][0];
        } else {
            d[u][0][1] = dd[1][1];
            d[u][0][0] = dd[1][0];
            d[u][1][1] = 0;
            d[u][1][0] = 0;
        }
        int t1 = stt[u]; stt[u] = 1 - t1;
        For(j,0,sz(ke[u])-1) {
                int v = ke[u][j];
                if (type[v] == 2) break;
                int t2 = stt[v];
                d[v][t2][t1]--;
                d[v][t2][1-t1]++;
            }
        For(t1,0,1) For(t2,0,1)
        if (t1 != t2) res[t1][t2] += d[u][t1][t2] + d[u][t2][t1];
        else res[t1][t2] += 2*d[u][t1][t2];
    } else {
        int t1 = stt[u];
        stt[u] = 1 - stt[u];
        For(j,0,sz(ke[u])-1) {
            int v = ke[u][j];
            int t2 = stt[v];
            res[t1][t2]--; res[1-t1][t2]++;
            res[t2][t1]--; res[t2][1-t1]++;
            if (type[v] == 1) {
                d[v][t2][t1]--; d[v][t2][1-t1]++;
            }
        }
    }
}

int main() {
    freopen("vmbw.inp","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d",&n,&m);
    p = trunc(sqrt(m));
    For(i,1,m) {
        int u,v;
        scanf("%d%d",&u,&v);
        ke[u].pb(v); ke[v].pb(u);
    }
    For(i,1,n) {
        if (sz(ke[i]) > p) type[i] = 1; else type[i] = 2;
        if (type[i] == 1) d[i][0][0] = sz(ke[i]);
        res[0][0] += sz(ke[i]);
    }
    For(i,1,n) sort(ke[i].begin(), ke[i].end(), cmp);
    For(i,1,n) {
        int k; scanf("%d",&k);
        if (k) change(i);
    }
    scanf("%d\n",&q);
    while (q) {
    	q--;
        string kind;
        int s1,s2;
        cin >> kind;
        if (kind == "print") {
            scanf("%d %d\n",&s1,&s2);
            if (s1 != s2) printf("%d\n",res[s1][s2]);
            else printf("%d\n",res[s1][s2]/2);
        } else {
            scanf("%d\n",&s1);
            change(s1);
        }
    }
}


