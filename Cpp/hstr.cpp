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
#define pb push_back
#define sz(s) int(s.size())
#define N 3010
#define M 1000000007

const int per[6][3] =
    {{0,1,2},{0,2,1},{1,2,0},{1,0,2},{2,1,0},{2,0,1}};

int n,k;
char s[2][N];
int f[N][N],mu[N],res;
int sl[3],h[3],ff[3],vt[3];

bool Check(int i, int j, int l) {
    return f[i][j] >= l;
}

int main() {
    freopen("hstr.inp","r",stdin);
  //  freopen("hstr.out","w",stdout);
    cin >> k;
    cin >> (s[0]+1); cin >> (s[1]+1);
    n = strlen(s[0]+1);
    For(i,1,n)
      For(j,1,n)
       if (abs(s[0][i]-s[1][j]) <= k) f[i][j] = f[i-1][j-1]+1;
        else f[i][j] = 0;
    For(i,1,n-2)
      For(j,i+1,n-1) {
        sl[0] = i, sl[2] = n-j, sl[1] = j-i;
        vt[0] = i; vt[1] = j; vt[2] = n;
        bool ok = false;
        For(k,0,5) {
            int sl1 = sl[per[k][0]], sl2 = sl[per[k][1]], sl3 = sl[per[k][2]];
            bool check = (Check(vt[per[k][0]],sl1,sl1)) & (Check(vt[per[k][1]],sl1+sl2,sl2)) & (Check(vt[per[k][2]],n,sl3));
            if (check) {
                ok = true;
                break;
            }
        }
        if (ok) res++;
      }
    cout << res;
}



