#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)

const int N = 1e5 + 10;

int deg[N], n;

int main() {
    //ifstream cin("in.txt");
    cin >> n;
    For(i, 1, n-1) {
        int u, v;
        cin >> u >> v;
        deg[u]++; deg[v]++;
    }
    long long ans = 0;
    For(u, 1, n) ans += (long long)deg[u]* (deg[u]-1)/2;
    cout << ans;
}
