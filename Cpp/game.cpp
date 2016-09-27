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

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 510

int root[N],n,ntest,p1,p2,g1,g2,r1,r2;
int u[N*N],v[N*N],m,uu,vv;

int GetRoot(int u) {
    while (root[u] > 0) u = root[u];
    return u;
}

void Union(int r1,int r2) {
    int x = root[r1] + root[r2];
    if (root[r1] > root[r2]) {
        root[r1] = r2;
        root[r2] = x;
    } else {
        root[r2] = r1;
        root[r1] = x;
    }
}

int main() {
    freopen("game.inp","r",stdin);
    freopen("game.out","w",stdout);
    scanf("%d",&ntest);
    while (ntest) {
        ntest--;
        scanf("%d",&n);
        For(i,1,n) root[i] = -1;
        m = (n*(n-1))/2;
        For(i,1,m) scanf("%d%d",&u[i],&v[i]);
        uu = u[m]; vv = v[m];
        For(i,1,m) {
            r1 = GetRoot(u[i]);
            r2 = GetRoot(v[i]);
            if (r1 != r2) {
                p1 = r1; p2 = r2; g1 = root[r1]; g2 = root[r2];
                Union(r1,r2);
                r1 = GetRoot(uu); r2 = GetRoot(vv);
                if (r1 == r2) {
                    root[p1] = g1; root[p2] = r2;
                    printf("0 ");
                } else printf("1 ");
            } else printf("0 ");
        }
        printf("\n");
    }
}



