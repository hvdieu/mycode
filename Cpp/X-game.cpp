#include <bits/stdc++.h>

using namespace std;

int n;
int f[1 << 25];

int bit(int x, int i) {
    return (x >> (i-1)) & 1;
}

bool check(int n, int mask) {
    for(int i = 3; i <= n; i++) if (bit(mask, i) && bit(mask, i-1) && bit(mask, i-2)) return false;
    if (f[mask] != -1) return f[mask];
    bool flag = false;
    for(int i = 1; i <= n; i++) if (!bit(mask, i))
        if (!check(n, mask + (1 << (i-1)))) flag = true;
    f[mask] = flag;
    return flag;
}

int main() {
   // freopen("output.txt", "w", stdout);
    for(n = 25; n <= 25; n++) {
        memset(f, -1, sizeof(f));
        if (check(n, 0)) cout << 1 << endl; else cout << 2 << endl;
    }
}
