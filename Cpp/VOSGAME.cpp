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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))

int ntest, n, x;

int main() {
    freopen("vosgame.inp","r",stdin);
   // freopen("vosgame.out","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        int res = 0;
        For(i, 1 ,n) {
            scanf("%d", &x);
            if (x == 1) res += x;
        }
        if (res % 2) printf("Aladdin\n"); else printf("Genie\n");
    }
}


