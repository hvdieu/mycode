#include <bits/stdc++.h>

using namespace std;

const int N = 100 + 10;

int n, a[N], res, pos[N], ntest;

void solve() {
    fill(pos+1, pos+n+1, 0);
    res = 0;
    for(int i = 1; i <= n; i++) {
        int j = a[i];
        int dem = 0;
        for(int k = 1; k < i; k++) if (pos[k] > pos[j]) dem++, pos[k]++;
        res += min(dem, i-1-dem);
        //if (!j) pos[i] = 1;
        pos[i] = pos[j]+1;
       // for(int i = 1; i <= n; i++) cout << pos[i] << ' '; cout << endl;
    }

    cout << res << endl;
}

int main() {
    //freopen("input.txt", "r", stdin);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        for(int i = 1; i <= n; i++) scanf("%d", a + i);
        solve();
    }
}
