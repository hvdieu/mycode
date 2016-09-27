#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)

const int N = 110;
const int h[4] = {-1, 0, 1, 0};
const int c[4] = {0, 1, 0, -1};

int n, cnt,m;
char s[N][N];
bool fr[N][N];

void dfs(int i, int j) {
    fr[i][j] = false;
    For(k, 0, 3) {
        int u = i + h[k], v = j + c[k];
        if (s[u][v] == 'B' && fr[u][v]) dfs(u, v);
    }
}

int main() {
    //freopen("in.txt", "r", stdin);
    cin >> n >> m;
    For(i, 1, n) scanf("%s\n", s[i]+1);
    memset(fr, true, sizeof fr);
    For(i, 1, n) For(j, 1, m) if (fr[i][j] && s[i][j] == 'B') {
        cnt++;
        dfs(i, j);
    }
    cout << cnt;
}
