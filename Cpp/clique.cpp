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
#define N 610

int n,m,k,deg[N],a[N];
int noi[N][N];
vector<int> ke[N],res;
bool dd[N];
bool found;
ll bit[N];

bool cmp(int i, int j) {
    return deg[i] < deg[j];
}

void duyet(int i,ll set1) {
    if (found==true) return;
    if (i > k) {
        found = true;
        For(j,0,n-1)
         if ((set1 >> (j)) & 1) printf("%d ",j+1);
        printf("\n");
        return;
    }
    int dem = 0;
    For(j,1,n) if (deg[a[j]] < k-1) break; else {
    	int bb = (set1 >> (a[j]-1)) & 1;
    	if (!bb) dem++;
    	if (n-dem-i+1 < k-i) break;
        if (!bb) {
            if ((bit[a[j]] & set1) == set1) duyet(i+1,set1 | (ll(1) << (a[j]-1)));
    	}
    }
}

void sub1() {
    res.clear();
    duyet(1,0);
}

void solve() {
    For(i,1,n) a[i] = i;
    sort(a+1,a+1+n,cmp);
    memset(dd,true,sizeof(dd));
    found = false;
    if (k==1) {
        cout << 1 << "\n";
        return;
    }
    else if (k <= 60) sub1();
    //else sub2();
    if (found==false) cout << -1 << "\n";
}

int main() {
    freopen("clique.inp","r",stdin);
    freopen("clique.out","w",stdout);
    int ntest;
    cin >> ntest;
    while (ntest) {
        ntest--;
        memset(noi,0,sizeof(noi));
        cin >> n >> m >> k;
        For(i,1,n) {
            ke[i].clear();
            deg[i] = 0;
            bit[i] = 0;
        }
        For(i,1,m) {
            int u,v;
            scanf("%d%d",&u,&v);
            noi[u][v] = 1;
            if (n <= 60) {
                bit[u] |= ll(1) << (v-1);
                bit[v] |= ll(1) << (u-1);
            }
            ke[u].pb(v); ke[v].pb(u);
            deg[u]++; deg[v]++;
        }
        solve();
    }
}



