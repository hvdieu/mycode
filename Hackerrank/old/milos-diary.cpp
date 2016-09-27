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

const int N = 10000000 + 10;

int n, a[N], top, st[N];
vector<int> b;

int main() {
    ios_base::sync_with_stdio(0);
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    while (cin >> n) {
        For(i, 1, n) cin >> a[i], b.push_back(a[i]);
        sort(all(b));
        For(i, 1, n) a[i] = lower_bound(all(b), a[i]) - b.begin() + 1;
        top = 0;
        int j = 1;
        For(i, 1, n) {
            while (j <= a[i]) st[++top] = j++;
            if (a[i] == st[top]) top--;
        }
        if (top) cout << "NO\n"; else cout << "YES\n";
    }
}


