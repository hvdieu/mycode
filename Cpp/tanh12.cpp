#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 1000010

ll f[2][2][2];
int n, a, first, last;

int main() {
  //  freopen("input.txt","r",stdin);
  // freopen("output.txt","w",stdout);
    while (scanf("%d", &n) != -1) {
        reset(f, 0);
        scanf("%d", &first);
        f[0][1][1] = first; f[0][0][0] = 0;
        int tt = 0;
        For(i, 2, n-1) {
            int x; tt = 1 - tt;
            scanf("%d", &x);
            f[tt][0][1] = max(f[1-tt][0][1], f[1-tt][1][1]);
            f[tt][0][0] = max(f[1-tt][0][0], f[1-tt][1][0]);
            f[tt][1][0] = f[1-tt][0][0]+x;
            f[tt][1][1] = f[1-tt][0][1]+x;
        }
        scanf("%d", &last);
        ll res = 0;
        res = max(f[tt][0][1], f[tt][1][1]);
        res = max(res, max(f[tt][1][0], f[tt][0][0]));
        res = max(res, f[tt][0][0] + last);
        cout << res << endl;
    }
}
