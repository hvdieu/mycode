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
#define M 10010

int n,m,x[M],y[M],root[N],next[M],rr[N],res;
vector<int> st[N];

int GetRoot(int u) {
    if (root[u] != u) root[u] = GetRoot(root[u]);
    return root[u];
}

int Get(int u) {
    if (rr[u] != u) rr[u] = Get(rr[u]);
    return rr[u];
}

void solve() {
    For(i,1,n) root[i] = i;
    res = n;
    next[0] = 0;
    int cnt = 0;
    Rep(i,m,1) {
        int r1 = GetRoot(x[i]), r2 = GetRoot(y[i]);
        if (r1 != r2) {
            res--;
            st[0].pb(i);
            root[r1] = r2;
        }
    }
    For(i,1,n) root[i] = i;
    For(i,1,m) {
        int r1 = GetRoot(x[i]), r2 = GetRoot(y[i]);
        if (r1 == r2) next[i] = next[i-1];
        else {
            cnt++;
            next[i] = cnt;
            root[r1] = r2;
            For(j,1,n) rr[j] = root[j];
            Rep(j,m,i+1) {
                int r1 = Get(x[j]), r2 = Get(y[j]);
                if (r1 != r2) {
                    rr[r1] = r2;
                    st[cnt].pb(j);
                }
            }
        }
    }
    int q,L,R;
    scanf("%d",&q);
    while (q) {
        q--;
        int kq = res;
        scanf("%d%d",&L,&R);
        int i = next[L-1];
        For(j,0,sz(st[i])-1)
          if (L <= st[i][j] && st[i][j] <= R) kq++;
        printf("%d\n",kq);
    }
    //cout << res;
}

int main() {
   // freopen("292D.inp","r",stdin);
   // freopen("292D.out","w",stdout);
    scanf("%d%d",&n,&m);
    For(i,1,m) scanf("%d%d",&x[i],&y[i]);
    solve();
}


