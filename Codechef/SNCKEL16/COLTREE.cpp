#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define REP(i, n) for(int i = 0; i < n; i++)

const int M = 1e9 + 7;
const int N = 55;

int n, k, ntest;
long long C[N][N], P[N][N], G[N];

int main() {
   // ifstream cin("in.txt");
    n = 50;
    For(j, 0, 50) C[0][j] = P[0][j] = 1;
    G[0] = 1;
    For(i, 1, n) G[i] = (G[i-1] * i) % M;
    For(j, 1, n)
        For(i, 1, j) {
            C[i][j] = (C[i][j-1] + C[i-1][j-1]) % M;
            P[i][j] = (C[i][j] * G[i]) % M;
        }
    cin >> ntest;
    while (ntest--) {
        cin >> n >> k;
        REP(i, n-1) {
            int u, v;
            cin >> u >> v;
        }
        long long res = 0;
        For(i, 1, min(k, n)) res = (res + (P[i][k] * C[i-1][n-1]) % M) % M;
        cout << res << "\n";
    }
}
