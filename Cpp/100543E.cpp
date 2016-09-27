#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
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

int ntest, n, a[N];
deque<int> q;
deque<int>::iterator it;

void solve() {
    string res; res.clear(); res.pb('r');
    q.clear();
    q.push_back(a[1]);
    For(i, 2, n) {
        bool left;
        if (a[i] == q.front()) left = true;
        else if (a[i] == q.back()) left = false;
        else if (a[i] > q.front() && a[i] > q.back()) {
            if (q.front() > q.back()) left = true;
            else left = false;
        } else if (a[i] < q.front() && a[i] < q.back()) {
            if (q.front() < q.back()) left = true;
            else left = false;
        } else if (a[i] < q.front()) left = true;
        else left = false;
        if (left) q.push_front(a[i]), res.pb('l');
        else q.push_back(a[i]), res.pb('r');
        while (sz(q) > 1) {
            it = q.begin(); int x = *it;
            it++; int y = *it;
            if (x == y) {
                q.pop_front(); q.front() *= 2;
            } else break;
        }
        while (sz(q) > 1) {
            it = q.end(); it--; int x = *it;
            it--; int y = *it;
            if (x == y) {
                q.pop_back(); q.back() *= 2;
            } else break;
        }
        FOR(it, q) cout << *it << ' '; cout << endl;
    }
    if (sz(q) == 1) cout << res << endl;
    else cout << "no" << endl;
}

int main() {
    freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d", &n);
        For(i, 1, n) scanf("%d", a+i);
        solve();
    }
}
