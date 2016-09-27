#include <bits/stdc++.h>

using namespace std;

typedef pair<int, int> ii;

const int N = 10000000;
const int Ntest = 10000000;

int ntest, n, p[N + 1], phi[N + 1], top;
int pr[50], pw[50], r;
int d[5000], cnt;
int in[Ntest];
long long out[Ntest];
ii st[5000];
long long ans;

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

int cal(int n) {
    if (phi[n]) return phi[n];
    if (!p[n]) phi[n] = n-1;
    else {
        int x = n;
        int j = p[x], tmp = 1;
        while (x % j == 0) x /= j, tmp *= j;
        phi[n] = ((long long)tmp - tmp / j) * cal(x);
    }
    return phi[n];
}

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("input.txt", "r", stdin);
    int ss = trunc(sqrt(N));
    for(int i = 2; i <= ss; i++)
    if (!p[i]) for(int j = i * i; j <= N; j += i) p[j] = i;
    scanf("%d", &ntest);
    for(int i = 0; i < ntest; i++) scanf("%d", in + i);
    phi[1] = 1;
    for(int i = 0; i < ntest; i++) {
        analyse(in[i]);
        ans = 0;
        for(int i = 1; i <= cnt; i++) {
            ans += (long long)d[i] * cal(d[i]);
        //    cout << d[i] << ' ' << phi[d[i]] << endl;
        }
        out[i] = ans;
    }
    for(int i = 0; i < ntest; i++) printf("%lld\n", out[i]);
}
