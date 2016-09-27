#include <cstdio>

const int N = 85;
const int MOD = 1e9 + 7;

int g[N][N], vis[N], bi[N][N], fact[N], d[N], c[N];

inline int pmod(int a, int b) {
  int r = 1;
  while (b) {
    if (b & 1) r = 1LL * a * r % MOD;
    a = 1LL * a * a % MOD;
    b >>= 1;
  }
  return r;
}

inline int nCk(int n, int k) {
  if (bi[n][k]) return bi[n][k];
  return bi[n][k] = 1LL * fact[n] * pmod(1LL * fact[n - k] * fact[k] % MOD, MOD - 2) % MOD;
}

int main() {
  freopen("out.txt","w",stdout);
  fact[0] = 1;
  for (int i = 1; i < 81; ++i) {
    fact[i] = 1LL * fact[i - 1] * i % MOD;
    d[i] = pmod(2, i * (i - 1));
    int v = 0;
    for (int j = 1; j < i; ++j) {
      v = (v + 1LL * j * nCk(i, j) % MOD * c[j] % MOD * d[i - j] % MOD) % MOD;
    }
    int vv=v;
    v = 1LL * v * pmod(i, MOD - 2) % MOD;
    c[i] = (d[i] - v+MOD) % MOD;
    printf("%d %d\n",c[i],v);
  }
}
