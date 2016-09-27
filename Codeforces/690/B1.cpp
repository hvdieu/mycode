#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)

const int N = 60;

char s[N][N];
int n;

int main() {
    //freopen("in.txt", "r", stdin);
    cin >> n;
    For(i, 1, n) scanf("%s\n", s[i]+1);
    int x1, x2, y1, y2;
    x1 = y1 = N;
    x2 = y2 = 0;
    int cnt = 0;
    For(i, 1, n) For(j, 1, n) if (s[i][j] == '4') {
        x1 = min(x1, i);
        y1 = min(y1, j);
        x2 = max(x2, i);
        y2 = max(y2, j);
        cnt++;
    }
    //cout << x1 << ' ' << y1 << ' ' << x2 << ' ' << y2 << ' ' << cnt << "\n";
    bool flag = true;
    if ((x2-x1+1) * (y2-y1+1) == cnt) {
        For(i, 1, n) For(j, 1, n) {
            if ((i == x1-1 || i == x2+1) && (j == y1-1 || j == y2+1) && s[i][j] != '1') flag = false;
            else if ((i == x1-1 || i == x2+1) && (j >= y1) && (j <= y2) && s[i][j] != '2') flag = false;
            else if ((j == y1-1 || j == y2+1) && (i >= x1) && (i <= x2) && s[i][j] != '2') flag = false;
            else if ((i > x2+1 || i < x1-1 || j > y2+1 || j < y1-1) && (s[i][j] != '0')) flag = false;
            //if (!flag) cout << i << ' ' << j << "\n";
        }
    } else flag = false;
    if (flag) cout << "Yes"; else cout << "No";
}
