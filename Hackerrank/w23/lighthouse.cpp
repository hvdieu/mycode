#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i--)

const int N = 50 + 5;

int n;
char s[N][N];

int dis(int i, int j, int u, int v) {
    int xx = abs(i-u), yy = abs(j-v);
    return xx*xx + yy*yy;
}

bool check(int r) {
    bool flag = false;
    For(i, 1, n) For(j, 1, n) if (s[i][j] == '.') {
        bool ok = true;
        For(u, i-r, i+r)
        For(v, j-r, j+r)
        if (dis(i, j, u, v) <= r*r) {
            if (u < 0 || v < 0 || u > n || v > n) {
                ok = false;
                break;
            }
            else if (s[u][v] != '.') {
                ok = false;
                break;
            }
        }
        flag |= ok;
    }
    return flag;
}

int main() {
    //freopen("in.txt", "r", stdin);
    scanf("%d\n", &n);
    For(i, 1, n) scanf("%s\n", s[i]+1);
    Rep(r, n, 0)
        if (check(r)) {
            cout << r;
            return 0;
        }
}
