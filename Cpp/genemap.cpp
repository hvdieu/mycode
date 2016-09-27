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

int n,k;
char s[N][200],pre[N][200],suf[N][200];

void solve() {
    m = 0;
    For(i,1,n) if (strlen(s[i]) >= k) {
        m++;
        For(j,1,k) {
            strcat(pre[m],s[i][j]);
            strcat()
    }

}

int main() {
    freopen("genenmap.inp","r",stdin);
    freopen("genemap.out","w",stdout);
    scanf("%d%d",&n,&k);
    For(i,1,n) scanf("%s\n",s[i]);
    solve();
}
