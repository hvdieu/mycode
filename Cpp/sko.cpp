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
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 10010
#define NN 500010

int n, xmin, xmax;
int f[NN];

int id(int x) {
    return x + 200000;
}

void fix(int i) {
    xmin = min(xmin, i); xmax = max(xmax, i);
    if (f[i] >= 3) {
        f[i-2] += f[i] / 3;
        f[i+2] += f[i] / 3;
        f[i] %= 3;
        fix(i-2); fix(i+2); fix(i);
    } else if (f[i] >= 1 && f[i-1] >= 1) {
        int x = min(f[i], f[i-1]);
        f[i+1] += x;
        f[i-1] -= x; f[i] -= x;
        fix(i+1);
    } else if (f[i] == 2) {
        f[i] = 0; f[i+1]++; f[i-2]++;
        fix(i-2); fix(i+1);
    }
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        int x, y; scanf("%d%d", &x, &y);
        f[id(x)] = y; if (i==1) xmin = id(x);
        xmax = id(x);
    }
    For(i, xmin, xmax) fix(i);
    For(i, xmin, xmax) if (f[i]) printf("%d ", i-200000);
    //cout << endl;
    //cout << xmin-200000 << ' ' << xmax-200000;
}
