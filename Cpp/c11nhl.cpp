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
#define N 510
const double eps = 0.000000001;
int m,n,k,t[N][N];
double s[N][N];
vector<ii> Q;

double sum(int i, int j, int u, int v) {
    return s[u][v] - s[u][j-1] - s[i-1][v] + s[i-1][j-1];
}

void update(int i,int j,int val) {
    while (i <= m) {
        int jj = j;
        while (jj <= n) {
            t[i][jj] += val;
            jj += jj & (-jj);
        }
        i += i & (-i);
    }
}

int get(int i, int j) {
    int res = 0;
    while (i) {
        int jj = j;
        while (jj) {
            res += t[i][jj];
            jj -= jj & (-jj);
        }
        i -= i & (-i);
    }
    return res;
}

int getsum(int i,int j,int u, int v) {
    return get(u,v) - get(u,j-1) - get(i-1,v) + get(i-1,j-1);
}

void solve() {
    int y;
    double yy;
    while (1) {
        int u = 0, v = 0;
        double temp = -1;
        For(i,1,m-k+1)
          For(j,1,n-k+1) {
            if (k != 1) y = getsum(i,j,i+k-1,j+k-1);
            else y = 0;
            yy = sum(i,j,i+k-1,j+k-1);
            if (yy-eps > temp && !y) {
                temp = sum(i,j,i+k-1,j+k-1);
                u = i; v = j;
            }
          }
        if (!u) break;
        Q.pb(ii(u,v));
        if (k != 1) {
            update(u,v,1); update(u,v+k-1,1); update(u+k-1,v,1); update(u+k-1,v+k-1,1);
        }
    }
}

int main() {
    freopen("C11NHL.INP","r",stdin);
    freopen("C11NHL.OUT","w",stdout);
    scanf("%d%d%d",&m,&n,&k);
    For(i,1,m) For(j,1,n) {
        int x; scanf("%d",&x);
        s[i][j] = s[i-1][j] + s[i][j-1] - s[i-1][j-1] + log(x);
    }
    solve();
    printf("%d\n",sz(Q));
    For(i,0,sz(Q)-1) printf("%d %d\n",Q[i].fi,Q[i].se);
}
