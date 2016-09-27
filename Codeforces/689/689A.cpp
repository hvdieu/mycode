#include <bits/stdc++.h>

using namespace std;
#define For(i, a, b) for(int i = a; i <= b; i++)
const int pos[10][2] = {{4,2}, {1, 1}, {1, 2}, {1, 3}, {2,1}, {2,2}, {2,3}, {3,1}, {3,2}, {3,3}};
int n;
string s;
bool fr[20][20];

int main() {
    //ifstream cin("input.txt");
    cin >> n;
    cin >> s;
    bool ans = true;
    For(i, 1, 4) For(j, 1, 3) fr[i][j] = true;
    fr[4][1] = fr[4][3] = false;
    for(int i = 0; i < 10; i++)
        if (i != s[0]-'0') {
            int x = pos[i][0], y = pos[i][1];
            bool flag = true;
            For(i, 1, n-1) {
                x += pos[s[i]-'0'][0] - pos[s[i-1]-'0'][0];
                y += pos[s[i]-'0'][1] - pos[s[i-1]-'0'][1];
                if (x > 0 && y > 0 && fr[x][y]) continue;
                else flag = false;
            }
            if (flag) ans = false;
        }
    if (ans) cout << "YES"; else cout << "NO";
}
