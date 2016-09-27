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

bool check(int x) {
    if (x == 1) return false;
    int ss = trunc(sqrt(x))+1;
    For(i, 2, ss) if (x % i == 0) return false;
    return true;
}

int n, res, a[10],len;

void str(int x) {
    while (x) {
        a[++len] = x % 10; x /= 10;
    }
}

void duyet(int i, int x) {
    if (i == 0) {
        if (x && check(x)) res = max(res, x);
        return;
    }
    duyet(i-1, x);
    duyet(i-1, x*10 + a[i]);
}

int main() {
    freopen("ngto.inp","r",stdin);
    freopen("ngto.out","w",stdout);
    cin >> n;
    str(n);
    res = -1;
    duyet(len, 0);
    cout << res;
}
