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
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1010

int n, x[N], k, last[N], res, a[N];
vector<int> st[N], s[N];
bool tt[N];

void init() {
    tt[0] = true; last[0] = 0;
    For(i, 1, n) {
        st[i] = st[i-1];
        last[i] = last[i-1];
        tt[i] = tt[i-1];
        while (!st[i].empty() && x[i] > st[i].back()) {
            if (st[i].back() != last[i]+1) tt[i] = false;
            last[i] = st[i].back();
            st[i].pop_back();
        }
        st[i].push_back(x[i]);
    }
}

int Find() {
    Rep(j, n-10, 0) if (a[j] == x[j]) return j;
    return 0;
}

void solve() {
    if (tt[n]) res++;
    For(test, 2, k) {
        next_permutation(x+1, x+n+1);
        int j = Find();
        if (n-j > 10) {
            init(); For(i, 1, n) a[i] = x[i];
            if (tt[n]) res++;
        } else if (tt[j]) {
            int luu = last[j]; bool flag = tt[j];
            For(i, j+1, n) {
                while (!st[j].empty() && x[i] > st[j].back()) {
                    if (st[j].back() != last[j] + 1) tt[j] = false;
                    last[j] = st[j].back();
                    s[i].push_back(st[j].back()); st[j].pop_back();
                }
                st[j].push_back(x[i]);
            }
            if (tt[j]) res++; last[j] = luu; tt[j] = flag;
            Rep(i, n, j+1) {
                st[j].pop_back();
                while (!s[i].empty()) {st[j].push_back(s[i].back()); s[i].pop_back(); }
            }
        }
    }
    cout << res;
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("ssort.inp","r",stdin);
    freopen("ssort.out","w",stdout);
    scanf("%d%d", &n, &k);
    For(i, 1, n) { scanf("%d", x+i); a[i] = x[i]; }
    //For(i, 1, n) x[i] = a[i] = i;
    init();
    solve();
}
