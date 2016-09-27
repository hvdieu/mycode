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

int n,a[N],b[N];
vector<ii> Q;

void solve() {
    sort(Q.begin(),Q.end());
    int dem = 1;

}

int main() {
    freopen("vpdomino.inp","r",stdin);
    freopen("vpdomino.out","w",stdout);
    scanf("%d",&n);
    For(i,1,n) {
        int u,v;
        scanf("%d%d",&u,&v);
        Q.pb(ii(u,i)); Q.pb(ii(v,i+n));
    }
    solve();
}



