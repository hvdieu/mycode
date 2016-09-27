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
#define N 1010
#define BASE 9901
#define K 501

unsigned int n,k,f[K][K];
bool check[K][K];

int cal(int i,int j) {
    if (!j) return 0;
    if (!i) return 1;
    if (check[i][j]) return f[i][j];
    check[i][j] = true;
    For(t,0,((i-1) / 2) - 1) f[i][j] = (f[i][j] + 2*cal(t,j-1)*cal(i-t-1,j-1)) % BASE;
    int t = (i - 1) / 2;
    if ((i-1) % 2 == 0) f[i][j] = (f[i][j] + cal(t,j-1) * cal(t,j-1)) % BASE;
    else f[i][j] = (f[i][j] + 2*cal(t,j-1)*cal(i-t-1,j-1)) % BASE;
    return f[i][j];
}

int main() {
    freopen("qbtreek.inp","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> k;
    if (n % 2 && 2*k-1 <= n) cout << (cal(n / 2,k) - cal(n / 2,k-1) + BASE) % BASE;
    else cout << 0;
}



