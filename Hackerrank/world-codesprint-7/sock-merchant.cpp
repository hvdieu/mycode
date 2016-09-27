#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))

const int N = 100 + 10;

int n, c[N], ans;

int main() {
    //freopen("in.txt","r",stdin);
    cin >> n;
    For(i, 1, n) cin >> c[i];
    sort(c+1, c+n+1);
    int i = 1;
    while (i <= n) {
        int j = i;
        while (j < n && c[j+1] == c[j]) j++;
        int l = j-i+1;
        ans += l / 2;
        i = j+1;
    }
    cout << ans;
}


