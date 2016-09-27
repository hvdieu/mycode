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
#define N 1010

int n,m,match[N],a[N],res,timer,kq;
vector<int> ke[N];
int dd[N];

ll random(ll x) {
    ll res = 0;
    double m = x;
    For(i,1,5) {
        res += (m/32768) * rand();
        m /= 32768;
    }
    return res;
}

int find(int u) {
    if (dd[u] == timer) return 0;
    dd[u] = timer;
    For(j,0,sz(ke[u])-1) {
        int v = ke[u][j];
        if (!match[v] || find(match[v])) {
            match[u] = v;
            match[v] = u;
            return 1;
        }
    }
    return 0;
}

int solve() {
    int res = 0;
    For(i,1,n) {
        int j = rand()%n+1;
        swap(a[i],a[j]);
    }
    For(i,1,n)
     if (!match[a[i]]) {
        timer++;
        match[a[i]] = a[i];
        res += find(a[i]);
        if (match[a[i]] == a[i]) match[a[i]] = 0;
     }
     return res;
}

int main() {
  //  freopen("qbflower.inp","r",stdin);
 //   freopen("qbflower.out","w",stdout);
    scanf("%d%d",&n,&m);
    For(i,1,m) {
        int u,v;
        scanf("%d%d",&u,&v);
        ke[u].pb(v); ke[v].pb(u);
    }
    For(i,1,n) a[i] = i;
    For(i,1,100) kq = max(kq, solve() );
    cout << n-kq;
}
