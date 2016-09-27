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
#define N 100001

priority_queue< ii, vector<ii>, greater<ii> > heap;
int n, m, t[N];
int tt[N];

void update(int i, int x) {
    for(i; i <= n; i += i & (-i)) t[i] += x;
}

int get(int i) {
    int s = 0;
    for(i; i; i -= i & (-i)) s += t[i];
    return s;
}

int sum(int i, int j) {
    return get(j) - get(i-1);
}

int LEFT(int i) {
    if (get(i) == i) return 0;
    int l = 1, r = i-1, mid, ans;
    while (l <= r) {
        mid = (l + r) / 2;
        if (sum(mid, i) != i-mid+1) {
            ans = mid; l = mid + 1;
        } else r = mid - 1;
    }
    return ans;
}

int RIGHT(int i) {
    if (sum(i, n) == n-i+1) return 0;
    int l = i + 1, r = n, mid, ans;
    while (l <= r) {
        mid = (l + r) / 2;
        if (sum(i, mid) != mid-i+1) {
            ans = mid; r = mid - 1;
        } else l = mid + 1;
    }
    return ans;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    For(test, 1, m) {
        int t, x, y;
        scanf("%d%d%d", &t, &x, &y);
        while (!heap.empty() && heap.top().fi < t) {
            update(heap.top().se, -1);
            tt[heap.top().se] = 0;
            heap.pop();
        }
        if (!tt[x]) {
            tt[x] = 1;
            printf("%d\n", x);
            
            heap.push(ii(t + y, x));
            update(x, 1);
        } else {
            int l = LEFT(x);
            int r = RIGHT(x);
            if (!l && !r) printf("0\n");
            else {
                int u; if (!l) u = r; else if (!r) u = l;
                else if (x - l <= r - x) u = l; else u = r;
                tt[u] = 1;
                printf("%d\n", u);
                update(u, 1);
                heap.push(ii(t + y, u));
            }
        }
    }
}
