#include <bits/stdc++.h>

using namespace std;

const int N = 110;

int n;
int dda[N], ddb[N], ddc[N];
int ddab[N][N], ddbc[N][N], ddca[N][N];
int ddabc[N][N][N];
long long res = 0;

int main() {
  freopen("exactone.inp", "r", stdin);
  freopen("exactone.out", "w", stdout);
  scanf("%d", &n);
  for (int i = 1; i <= n; i++) {
    int a, b, c;
    scanf("%d %d %d", &a, &b, &c);
    res += dda[a] + ddb[b] + ddc[c];
    res += 3 * (ddabc[a][b][c]);
    res -= 2 * (ddab[a][b] + ddbc[b][c] + ddca[c][a]);
    dda[a]++, ddb[b]++, ddc[c]++;
    ddab[a][b]++, ddbc[b][c]++, ddca[c][a]++;
    ddabc[a][b][c]++;
  }
  cout << res << endl;
  return 0;
}
