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
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 100010

char s[N];
int n,res,dem[257],sum,m;
bool fr[257];
vector<int> ke[257];

void dfs(int u) {
    fr[u]=false; sum+=dem[u];
    m=max(m,dem[u]);
    For(j,0,sz(ke[u])-1) {
        int v=ke[u][j];
        if (fr[v]) dfs(v);
    }
}

int main() {
    freopen("TOPALIN.INP","r",stdin);
    freopen("TOPALIN.OUT","w",stdout);
    cin >> (s+1);
    n = strlen(s+1);
    For(i,1,n) dem[int(s[i])]++;
    For(i,1,n/2) {
        int j=n-i+1;
        if (s[i]!=s[j]) {
            int c1=int(s[i]), c2=int(s[j]);
            ke[c1].pb(c2); ke[c2].pb(c1);
        }
    }
    memset(fr,true,sizeof(fr));
    For(i,0,255) if (fr[i]) {
        sum=0; m=0;
        dfs(i);
        res+=sum-m;
    }
    cout << res;
}


