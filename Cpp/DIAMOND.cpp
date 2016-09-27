#include <bits/stdc++.h>

using namespace std;

const int N = 500 + 10;

char s[N][N];
int m, n, res, rx, ry;
int f[N][N][4];

int main() {
	//freopen("input.txt", "r", stdin);
	scanf("%d%d\n", &m, &n);
	for(int i = 1; i <= m; i++) scanf("%s\n", s[i]+1);
	//for(int i = 1; i <= m; i++)
    //for(int j = 1; j <= n; j++) cout << s[i][j];
    for(char ch = 'A'; ch <= 'Z'; ch++) {
        memset(f, 0, sizeof f);

        for(int i = 1; i <= m; i++)
        for(int j = 1; j <= n; j++)
        if (s[i][j] != ch) f[i][j][0] = 0;
        else f[i][j][0] = min(f[i][j-1][0], f[i-1][j][0]) + 1;

        for(int i = 1; i <= m; i++)
        for(int j = n; j >= 1; j--)
        if (s[i][j] != ch) f[i][j][1] = 0;
        else f[i][j][1] = min(f[i][j+1][1], f[i-1][j][1]) + 1;

        for(int i = m; i >= 1; i--)
        for(int j = 1; j <= n; j++)
        if (s[i][j] != ch) f[i][j][2] = 0;
        else f[i][j][2] = min(f[i+1][j][2], f[i][j-1][2]) + 1;

        for(int i = m; i >= 1; i--)
        for(int j = n; j >= 1; j--)
        if (s[i][j] != ch) f[i][j][3] = 0;
        else f[i][j][3] = min(f[i+1][j][3], f[i][j+1][3]) + 1;

        for(int i = 1; i <= m; i++)
        for(int j = 1; j <= n; j++) {
            int tmp = min(min(f[i][j][0], f[i][j][1]), min(f[i][j][2], f[i][j][3]));
            if (tmp > res || (tmp == res && (i < rx || (i == rx && j < ry)))) {
                res = tmp;
                rx = i; ry = j;
            }
        }
        //cout << f[2][3][0] << ' ' << f[2][3][1] << ' ' << f[2][3][2] << ' ' << f[2][3][3] << "\n";
    }
    cout << rx << ' ' << ry << ' ' << res-1;
}
