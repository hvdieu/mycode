#include <bits/stdc++.h>

using namespace std;

#define N 10000001
#define inf 1000000000000000LL

int n, K, L, pos[N];
long long f[N], g[N], res;

int main() {
    scanf("%d%d%d", &n, &K, &L);
    for(int i = 1; i <= n; i++) scanf("%d", pos + i);
    for(int i = 1; i <= n; i++) f[i] = f[max(i-K, 0)] + 2 * pos[i];
    for(int i = n; i > 0; i--) g[i] = g[min(i+K, n+1)] + 2 * (L - pos[i]);
    res = inf;
    for(int i = 0; i <= n; i++) {
        res = min(res, f[i] + g[i+1]);
        res = min(res, f[i] + g[min(i+K+1, n+1)] + L);
    }
    printf("%lld", res);
}


