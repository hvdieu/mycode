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

int ntest, m, n, a[N][N], h[N], st[N], top, lef[N], k, r1, res;
vector<int> q;

bool check(int key) {
    res = 0; reset(h, 0);
    For(i, 1, m) {
        top = 0; st[0] = 0;
        For(j, 1, n) {
            if (a[i][j] >= key) h[j]++; else h[j] = 0;
            while (top && h[j] <= h[st[top]]) top--;
            lef[j] = j - st[top];
            st[++top] = j;
        }
        top = 0; st[0] = n+1;
        Rep(j, n, 1) {
            while (top && h[j] <= h[st[top]]) top--;
            res = max(res, h[j] * (lef[j] + (st[top] - j-1)));
            st[++top] = j;
        }
    }
    return res >= k;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        q.clear();
        scanf("%d%d%d", &m, &n, &k);
        For(i, 1, m) For(j, 1, n) {
            scanf("%d", &a[i][j]);
            q.pb(a[i][j]);
        }
        sort(all(q)); q.erase(unique(all(q)), q.end());
        int d = 0, c = sz(q)-1, mid, ans;
       // cout << sz(q) << endl;
        //check(8);
      //  FOR(it, q) cout << *it << ' '; cout << endl;
        while (d <= c) {
            mid = (d+c)/2;
            int key = q[mid];
            if (check(key)) {
                ans = key; d = mid+1;
                r1 = res;
            } else c = mid-1;
        }
        cout << ans << ' ' << r1 << endl;
    }
}
