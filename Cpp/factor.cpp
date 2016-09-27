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
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 5000001
#define inf 1000000
int n;
int f[N];
bool check[N];

int cal(int n) {
    if (check[n]) return f[n];
    if (n == 1) return 0;
    if (n == 2) return 1;
    f[n] = cal(n - 1) + n - 1;
    int bound = trunc(sqrt(n));
    For(i, 2, bound) if (n % i == 0) {
        int j = n / i;
        if (j > 1) {
            int x = min(cal(i - 1) + cal(j) + j, cal(i) + cal(j - 1) + i);
            if (f[n] > x) f[n] = x;
        }
    }
    check[n] = true;
    return f[n];
}

int main() {
    freopen("factor.inp","r",stdin);
    //freopen("factor.out","w",stdout);
    cin >> n;
    cout << cal(n);
}
