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

vector<int> ke[N];
int n,c[N],res,deg[N],d[N];
int st[4][N],bot[4],top[4];

bool stop() {
    return bot[1] + bot[2] + bot[3] == n;
}

void solve() {
    res = 1000000000;
    For(nn,1,3) {
        int now = nn,kq = 0;
        top[1] = top[2] = top[3] = bot[1] = bot[2] = bot[3] = 0;
        For(i,1,n) {
            d[i] = deg[i];
            if (!d[i]) st[c[i]][++top[c[i]]] = i;
        }
        while (1) {
            while (bot[now] < top[now]) {
                int u = st[now][++bot[now]]; kq++;
                For(j,0,sz(ke[u])-1) {
                    int v = ke[u][j];
                    d[v]--;
                    if (!d[v]) st[c[v]][++top[c[v]]] = v;
                }
            }
            if (stop()) break; else {
                kq++;
                now++; if (now > 3) now = 1;
            }
        }
        res = min(res,kq);
    }
    cout << res;
}

int main() {
   // freopen("213A.inp","r",stdin);
   // freopen("213A.out","w",stdout);
    scanf("%d",&n);
    For(i,1,n) scanf("%d",&c[i]);
    For(i,1,n) {
        int m,u;
        scanf("%d",&m);
        deg[i] = m;
        For(j,1,m) {
            scanf("%d",&u);
            ke[u].pb(i);
        }
    }
    solve();
}


