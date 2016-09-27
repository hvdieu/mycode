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
#define N 500010

int n,BASE,con[N],dd[N],res,c[N],p[N],st[N],jj[N],cha[N],top;
vector<int> ke[N];

void sieve() {
    int ss = trunc(sqrt(n));
    For(i,2,ss) if (!p[i]) {
        int j = i*i;
        while (j <= n) {
            p[j] = i; j = j+i;
        }
    }
}

void dfs() {
    int u,v;
    st[++top] = 1;
    while (top) {
        u = st[top];
        if (jj[u] == sz(ke[u])) {
            con[u]++;
            if (cha[u]) con[cha[u]] += con[u];
            top--;
        } else {
            v = ke[u][jj[u]]; jj[u]++;
            st[++top] = v;
        }
    }
}

int mu(int a,int b) {
    if (b == 0) return 1 % BASE;
    if (b == 1) return a % BASE;
    int c = mu(a,b/2);
    c = (ll(c) * c) % BASE;
    if (b % 2 == 0) return c;
    return (ll(c) * a) % BASE;
}

int main() {
    //freopen("cheap.inp","r",stdin);
    //freopen("cheap.out","w",stdout);
    scanf("%d%d",&n,&BASE);
    For(i,2,n) {
        int u; scanf("%d",&u);
        cha[i] = u;
        ke[u].pb(i);
    }
    sieve();
    dfs();
    For(i,2,n) dd[con[i]]--;
    For(i,2,con[1]-1) dd[i]++;
    For(x,2,n) if (dd[x] != 0) {
        int y = x;
        while (p[y]) {
            int j = p[y], dem = 0;
            while (y % j == 0) {
                dem++; y /= j;
            }
            c[j] += dd[x]*dem;
        }
        if (y > 1) c[y] += dd[x];
    }
    res = 1;
    For(i,2,n) if (c[i]) res = (ll(res) * mu(i,c[i])) % BASE;
    cout << res;
}




