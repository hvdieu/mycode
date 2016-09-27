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
#define inf 1000000000
#define sz(s) int(s.size())
const int N = 210;

int n;
char s[N];
int f[N][N][N],dem[N][10];

void solve() {
    For(i,1,n)
      For(j,1,n)
        For(k,1,n) f[i][j][k] = -inf;
    For(i,1,n) {
        f[i][i][0] = 1;
        f[i][i][1] = 0;
        if (i<n && s[i]==s[i+1]) {
            f[i][i+1][0] = 4;
            f[i][i+1][2] = 0;
        } else f[i][i+1][0] = 2;
        f[i][i+1][1] = 1;
    }
    For(i,1,n) {
        int ch = int(s[i]) - int('0');
        For(j,0,9) dem[i][j] = dem[i-1][j];
        dem[i][ch]++;
    }
    For(l,3,n) {
      For(i,1,n-l+1) {
         int j = i+l-1;
         For(k,i,j-1) f[i][j][0] = max(f[i][j][0], f[i][k][0]+f[k+1][j][0]);
         int ch = int(s[i]) - int('0');
         For(k,1,dem[j][ch]-dem[i-1][ch]) {
            if (s[i]==s[j]) f[i][j][k] = max(f[i][j][k],f[i][j-1][k-1]);
            For(t,i,j-1)
              if (s[i]==s[t])
                 f[i][j][k] = max(f[i][j][k], f[i][t][k]+f[t+1][j][0]);
            f[i][j][0] = max(f[i][j][0],f[i][j][k] + k*k);
         }
      }
    }
    cout << f[1][n][0];
}

int main() {
    freopen("CUTSEG.INP","r",stdin);
    freopen("CUTSEG.OUT","w",stdout);
    scanf("%d",&n);
    cin >> (s+1);
    solve();
}


