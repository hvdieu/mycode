#include <bits/stdc++.h>

using namespace std;

typedef pair<int, int> ii;

#define For(i, a, b) for(int i = a; i <= b; i++)

const int N = 200000 + 10;
const int M = 1e9 + 7;

int n, k;
vector<ii> Q;
long long g[N];
long long ans;

long long pw(long long a, long long n) {
    long long res = 1;
    while (n) {
        if (n & 1) res = (res * a) % M;
        n >>= 1;
        a = (a * a) % M;
    }
    return res;
}

long long cal(int n) {
    long long y = (g[k] * g[n-k]) % M;
    y = pw(y, M-2);
    return (g[n] * y) % M;
}

int main() {
   // ifstream cin("input.txt");
    cin >> n >> k;
    g[0] = 1;
    For(i, 1, n) g[i] = (g[i-1] * i) % M;
    //cout << pw(3, 2) << "\n";
    For(i, 1, n) {
        int u, v;
        cin >> u >> v;
        Q.push_back(ii(u, 0));
        Q.push_back(ii(v+1, 1));
    }
    sort(Q.begin(), Q.end());
    int now = 0;
    for(int i = 0; i < Q.size(); i++) {
        int x = Q[i].first, tt = Q[i].second;
       // cout << x << ' ' << tt << ' ' << cal(now) << "\n";
        if (i > 0 && now >= k) {
            ans += (cal(now) * (Q[i].first - Q[i-1].first)) % M;
            ans %= M;
        }
        if (tt == 0) now++;
        else now--;
    }
    cout << ans;
}
