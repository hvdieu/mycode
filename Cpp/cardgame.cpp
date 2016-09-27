#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i--)

const int N = 2*50000 + 10;

int n, a[N], b[N];
bool was[N];
set<int> minSet;
set<int, greater<int> > maxSet;

int main() {
    freopen("cardgame.in", "r", stdin);
    freopen("cardgame.out", "w", stdout);
    cin >> n;
    For(i, 1, n) cin >> a[i], was[a[i]] = true;
    int m = 0;
    For(i, 1, 2*n) if (!was[i]) b[++m] = i;
    sort(b+1, b+n+1, greater<int>());
    For(i, 1, n/2) minSet.insert(b[i]);
    For(i, n/2+1, n) maxSet.insert(b[i]);
    int ans = 0;
    For(i, 1, n/2) {
        set<int>::iterator it = minSet.upper_bound(a[i]);
        if (it != minSet.end()) {
            ans++;
            minSet.erase(it);
        } else minSet.erase(minSet.begin());
    }
    For(i, n/2+1, n) {
        set<int, greater<int> >::iterator it = maxSet.upper_bound(a[i]);
        if (it != maxSet.end()) {
            ans++;
            maxSet.erase(it);
        } else maxSet.erase(maxSet.begin());
    }
    cout << ans;
}
