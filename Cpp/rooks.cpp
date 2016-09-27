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
#define N 3010

struct node {
    int l, r, id;
};

int n, x[N], y[N];
node a[N], b[N];
priority_queue<ii, vector<ii>, greater<ii> > heap;

bool cmp(node a, node b) {
    return a.l < b.l;
}

void solve() {
    sort(a+1, a+n+1, cmp);
    sort(b+1, b+n+1, cmp);
    int j = 0;
    while (!heap.empty()) heap.pop();
    For(i, 1, n) {
        while (j < n && a[j+1].l <= i) {
            heap.push(ii(a[j+1].r, a[j+1].id)); j++;
        }
        if (heap.empty()) {
            cout << "NIE"; return;
        }
        if (heap.top().fi >= i) {
            x[heap.top().se] = i; heap.pop();
        } else {
            cout << "NIE"; return;
        }
    }
    j = 0;
    while (!heap.empty()) heap.pop();
    For(i, 1, n) {
        while (j < n && b[j+1].l <= i) {
            heap.push(ii(b[j+1].r, b[j+1].id)); j++;
        }
        if (heap.empty()) {
            cout << "NIE"; return;
        }
        if (heap.top().fi >= i) {
            y[heap.top().se] = i; heap.pop();
        } else {
            cout << "NIE"; return;
        }
    }
    For(i, 1, n) cout << x[i] << ' ' << y[i] << endl;
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d%d%d%d", &a[i].l, &b[i].l, &a[i].r, &b[i].r);
        a[i].id = b[i].id = i;
    }
    solve();
}
