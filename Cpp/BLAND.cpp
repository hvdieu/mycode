#include <bits/stdc++.h>

using namespace std;

const int N = 300 + 10;

int m, n, k, a[N][N], ans, l[N], r[N], h[N], f[4][N], b[N][N];
vector<int> val;
int top, st[N];

void rotate() {
    for(int i = 1; i <= m; i++)
        for(int j = 1; j <= n; j++) b[j][m-i+1] = a[i][j];
    swap(m, n);
    for(int i = 1; i <= m; i++)
        for(int j = 1; j <= n; j++) a[i][j] = b[i][j];
}

void init(int k, int MIN, int MAX) {
    memset(h, 0, sizeof h);
    for(int i = 1; i <= m; i++) {
        for(int j = 1; j <= n; j++) if (a[i][j] >= MIN && a[i][j] <= MAX) h[j]++; else h[j] = 0;
        top = 0; st[0] = 0;
        for(int j = 1; j <= n; j++) {
            if (h[j] > h[j-1]) {
                l[j] = 1;
                st[++top] = j;
            } else {
                while (top && h[st[top]] >= h[j]) top--;
                l[j] = j - st[top];
                st[++top] = j;
            }
        }
        top = 0; st[0] = n+1;
        for(int j = n; j > 0; j--) {
            if (h[j] > h[j+1]) {
                r[j] = 1;
                st[++top] = j;
            } else {
                while (top && h[st[top]] >= h[j]) top--;
                r[j] = st[top] - j;
                st[++top] = j;
            }
        }
        f[k][i] = max(f[k][i], f[k][i-1]);
        for(int j = 1; j <= n; j++) f[k][i] = max(f[k][i], h[j] * (l[j] + r[j] - 1));
    }
}

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("input.txt", "r", stdin);
    cin >> m >> n >> k;
    for(int i = 1; i <= m; i++)
    for(int j = 1; j <= n; j++) {
        cin >> a[i][j];
        val.push_back(a[i][j]);
    }
    sort(val.begin(), val.end());
    val.erase(unique(val.begin(), val.end()), val.end());
    for(int x : val) {
        for(int dir = 0; dir < 4; dir++) {
            init(dir, x, x + k);
            rotate();
        }
    }
    for(int i = 1; i < m; i++) {
        ans = max(ans, f[0][i] + f[2][m-i]);
       // cout << f[0][i] << ' ' << f[2][m-i] << "\n";
    }
    for(int j = 1; j < n; j++) {
        ans = max(ans, f[1][j] + f[3][n-j]);
        //cout << f[1][j] << ' ' << f[3][n-j] << "\n";
    }
    cout << ans;
}
