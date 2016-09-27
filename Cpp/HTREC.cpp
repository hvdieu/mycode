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
#define N 50010

struct line {
    int x1,x2;
}

int n,gt[2*N],m,yy[N],xx1[N],xx2[N],dem;
vector<line> a[1001];
ii b[2*N];

void solve() {
    b[0].fi = -1;
    sort(b+1,b+2*n+1);
    dem = 0;
    For(i,1,2*n) {
        if (b[i].fi != b[i-1].fi) dem++;
        gt[dem] = b[i].fi;
        if (b[i].se > n) xx2[b[i].se-n] = dem;
        else xx1[b[i].se] = dem;
    }
    For(i,1,n) {
        int y = yy[i];
        line X; X.x1 = xx1[i]; X.x2 = xx2[i];
        a[y].pb(X);
    }
    For(i,0,1000) sort(a[i].begin(),a[i].end(),cmp);
    For(y,0,1000) if (sz(a[i])) {
        For(i,0,sz(a[i])-1) {
            s[y][a[i].x1]++; s[y][a[i].x2+1]--;
        }
    }
}

int main() {
    freopen("htrec.inp","r",stdin);
    freopen("htrec.out","w",stdout);
    scanf("%d",&n);
    For(i,1,n) {
        int y,x1,x2;
        scanf("%d %d %d",&y,&x1,&x2);
        yy[i] = y;
        line X; X.x1 = x1; X.x2 = x2;
        a[y].pb(X);
        b[++m].fi = x1; b[m].se = i; b[++m] = x2; b[m].se = i+n;
    }
    solve();
}
