#include <bits/stdc++.h>

using namespace std;

const int N = 100000 + 1;
const int BASE = int(1e9) + 7;

int ntest, k, n;
long long res;
vector<pair<long long, int>> q;

void solve() {
    if (k == n) {
        res = 1;
        for(int i = 1; i <= 100; i++) res = (res * 10) % BASE;
        res = res + 1;
    } else {
        sort(q.begin(), q.end());
        int tmp = 0;
        int i = 0;
        res = 0;
        while (i < q.size()) {
        	if (tmp >= n-k) res += q[i].first - q[i-1].first;
            int j = i;
            while (j < q.size() && q[j].first == q[i].first) j++;
            for(int k = i; k < j; k++) {
                if (!q[k].second) tmp++;
                else tmp--;
            }
            i = j;
        }
    }
    cout << res % BASE << endl;
}

int main() {
   // freopen("input.txt", "r", stdin);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d", &n, &k);
        q.clear();
        for(int i = 1; i <= n; i++) {
            long long x, d;
            scanf("%lld %lld", &x, &d);
            q.push_back(make_pair(x*d, 0));
            q.push_back(make_pair(x*d + x, 1));
        }
        solve();
    }
}
