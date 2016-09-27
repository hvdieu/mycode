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
#define N 110
#define MAX 10000
#define inf 100000000000000000LL

int a[N], n;
ll s, res;
queue<int> q;
ll f[2*MAX];
int trace[2*MAX];
ll kq[N];

void bfs() {
    For(i, 0, 2*MAX) f[i] = inf;
    f[MAX] = 0;
    q.push(0);
    while (!q.empty()) {
        int x = q.front(); q.pop();
        For(i, 1, n) {
            if (x + a[i] <= MAX && f[x + a[i] + MAX] > f[x + MAX] + 1) {
                f[x + a[i] + MAX] = f[x + MAX] + 1;
                trace[x + a[i] + MAX] = i;
                q.push(x + a[i]);
            }
            if (x - a[i] >= -MAX && f[x - a[i] + MAX] > f[x + MAX] + 1) {
                f[x - a[i] + MAX] = f[x + MAX] + 1;
                trace[x - a[i] + MAX] = -i;
                q.push(x - a[i]);
            }
        }
    }
}

void tv(int x) {
    if (!x) return;
    int y;
    int i = trace[x + MAX];
    if (i > 0) kq[i]++, y = x - a[i];
    else kq[-i]--, y = x + a[-i];
    tv(y);
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%lld%d", &s, &n);
    For(i, 1, n) scanf("%d", a+i);
    if (s > MAX) {
        kq[n] = s / a[n];
        s %= a[n];
        while (s + a[n] < MAX) {
            kq[n]--;
            s += a[n];
        }
    }
    bfs();
    tv(s);
    For(i, 1, n) cout << kq[i] << ' ';
}
