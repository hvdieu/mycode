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
#define N 21
#define inf 10000000

const int h[4] = {-1,0,1,0};
const int c[4] = {0,1,0,-1};

int m,n,s[N][N],f[N][N][N][N][4],next[4];
bool check[N][N][N][N][4];

int sum(int i,int j,int u,int v) {
	if (i > u) swap(i,u);
	if (j > v) swap(j,v);
    return s[u][v] - s[u][j-1] - s[i-1][v] + s[i-1][j-1];
}

int cal(int i,int j,int l1, int l2, int dir) {
    if (l2 == 1) return 0;
    if (check[i][j][l1][l2][dir]) return f[i][j][l1][l2][dir];
    int res;
    if (!j) res = -inf; else res = 0;
    For(k,1,l2-1) {
        int u = i + k * h[dir];
        int v = j + k * c[dir];
        int x = sum(i+h[dir],j+c[dir],u,v);
        int y = x + cal(u,v,k,l1,next[dir]);
        res = max(res,y);
    }
    check[i][j][l1][l2][dir] = true;
    f[i][j][l1][l2][dir] = res;
    return res;
}

int main() {
   // freopen("f1.inp","r",stdin);
    //freopen("f1.out","w",stdout);
    scanf("%d%d",&m,&n);
    For(i,1,m) For(j,1,n) {
        int x;
        scanf("%d",&x); s[i][j] = s[i][j-1] + s[i-1][j] - s[i-1][j-1] + x;
    }
    next[0] = 1; next[1] = 2; next[2] = 3; next[3] = 0;
    int res = cal(1,0,m,n+1,1);
    cout << res;
    //cout << s[m][n];
}


