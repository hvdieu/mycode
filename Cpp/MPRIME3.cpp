#include <bits/stdc++.h>

using namespace std;

typedef pair<int, int> ii;

const int N = 100000;
const int MAX = 1000000;

int n, a[N + 10], f[MAX + 10], p[MAX + 10], u[MAX + 10];
int d[5000], cnt, r, pw[5000], pr[5000], top;
ii st[5000];

void analyse(int x) {
    r = 0;
    while (p[x]) {
        int j = p[x];
        pr[++r] = j; pw[r] = 0;
        while (x % j == 0) {
            pw[r]++; x /= j;
        }
    }
    if (x > 1) pr[++r] = x, pw[r] = 1;

    cnt = 0;
    top = 1; st[top] = ii(1, 1);
    while (top) {
        int i = st[top].first, val = st[top].second; top--;
        if (i > r) {
            d[++cnt] = val; continue;
        }
        st[++top] = ii(i+1, val);
        for(int j = 1; j <= pw[i]; j++) {
            val *= pr[i];
            st[++top] = ii(i+1, val);
        }
    }
}

int cal(int x) {
    r = 0;
    while (p[x]) {
        int j = p[x];
        pr[++r] = j; pw[r] = 0;
        while (x % j == 0) {
            pw[r]++; x /= j;
        }
    }
    if (x > 1) pr[++r] = x, pw[r] = 1;
    for(int i = 1; i <= r; i++) if (pw[i] > 1) return 0;
    if (r % 2) return -1;
    return 1;
}

long long C(long long n) {
    return n * (n-1) * (n-2) / 6;
}

int main() {
    freopen("MPRIME3.INP", "r", stdin);
    freopen("MPRIME3.OUT", "w", stdout);
    scanf("%d", &n);
    int ss = trunc(sqrt(MAX));
    for(int i = 2; i <= ss; i++)
    if (!p[i]) for(int j = i * i; j <= MAX; j += i) p[j] = i;
    for(int i = 1; i <= n; i++) {
        int x;
        scanf("%d", &x);
        analyse(x);
        for(int j = 1; j <= cnt; j++) f[d[j]]++;
    }

    u[1] = 1;
    long long res = 0;
    for(int i = 1; i <= MAX; i++) {
        u[i] = cal(i);
        if (f[i] >= 3) res += C(f[i]) * u[i];
    }
    //for(int i = 1; i <= 30; i++) cout << i <<' '<< u[i] << endl;
    cout << res;
}
