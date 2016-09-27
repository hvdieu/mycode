#include <bits/stdc++.h>

using namespace std;

const int N = 1000 + 10;

int m, n;
char a[N][N];
int f[N][N][4], s[2*N][2*N];
int S, R, Rx, Ry;

int tx(int x, int y) {
    return x - y + n;
}

int ty(int x, int y) {
    return x + y;
}

int get(int i, int j, int r) {
    int x1 = tx(i, j) - r, y1 = ty(i, j) - r;
    int x2 = tx(i, j) + r, y2 = ty(i, j) + r;
    return s[x2][y2] - s[x1-1][y2] - s[x2][y1-1] + s[x1-1][y1-1];
}

int main() {
    //freopen("input.txt", "r", stdin);
    scanf("%d%d\n", &m, &n);
    for(int i = 1; i <= m; i++) scanf("%s\n", a[i]+1);
    memset(f, 0xff, sizeof f);

    for(int i = 1; i <= m; i++)
        for(int j = 1; j <= n; j++)
            if (a[i][j] == '*' && (a[i-1][j] == '*' || a[i][j-1] == '*')) f[i][j][0] = 0;
            else f[i][j][0] = min(f[i-1][j][0], f[i][j-1][0]) + 1;

    for(int i = 1; i <= m; i++)
        for(int j = n; j >= 1; j--)
            if (a[i][j] == '*' && (a[i-1][j] == '*' || a[i][j+1] == '*')) f[i][j][1] = 0;
            else f[i][j][1] = min(f[i-1][j][1], f[i][j+1][1]) + 1;

    for(int i = m; i >= 1; i--)
        for(int j = 1; j <= n; j++)
            if (a[i][j] == '*' && (a[i+1][j] == '*' || a[i][j-1] == '*')) f[i][j][2] = 0;
            else f[i][j][2] = min(f[i+1][j][2], f[i][j-1][2]) + 1;

    for(int i = m; i >= 1; i--)
        for(int j = n; j >= 1; j--)
            if (a[i][j] == '*' && (a[i+1][j] == '*' || a[i][j+1] == '*')) f[i][j][3] = 0;
            else f[i][j][3] = min(f[i][j+1][3], f[i+1][j][3]) + 1;

    for(int i = 1; i <= m; i++)
        for(int j = 1; j <= n; j++)
            if (a[i][j] == '*') s[tx(i, j)][ty(i, j)]++;

    for(int i = 1; i <= m+n; i++)
        for(int j = 1; j <= m+n; j++)
            s[i][j] += s[i][j-1] + s[i-1][j] - s[i-1][j-1];

    S = -1;
    for(int i = 1; i <= m; i++)
        for(int j = 1; j <= n; j++) {
            int r = min(min(f[i][j][0], f[i][j][1]), min(f[i][j][2], f[i][j][3]));
            int sum = get(i, j, r);
            //cout << sum << ' ';
            if (sum > S) {
                S = sum;
                Rx = i; Ry = j; R = r;
            }
        }
    //cout << get(26, 17, 16) << "\n";
    //cout << f[15][24][0] << "\n";
    cout << S << ' ' << Rx << ' ' << Ry << ' ' << R;
}
