#include <bits/stdc++.h>

using namespace std;

const int N = 101;
const int h[4] = {-1, 0, 1, 0};
const int c[4] = {0, 1, 0, -1};

int n;
char s[N][N];

int main() {
    //freopen("in.txt", "r", stdin);
    scanf("%d\n", &n);
    for(int i = 1; i <= n; i++) scanf("%s\n", s[i]+1);
    string ans = "YES";
    for(int i = 1; i <= n; i++)
        for(int j = 1; j <= n; j++) {
            int cnt = 0;
            for(int k = 0; k < 4; k++) {
                int u = i + h[k], v = j + c[k];
                if (u && v && u <= n && v <= n) cnt += (s[u][v] == 'o');
            }
            //if (i == 1 && j == 4) cout << cnt << "\n";
            if (cnt % 2) ans = "NO";
        }
    cout << ans;
}
