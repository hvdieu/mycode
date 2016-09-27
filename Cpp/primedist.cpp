#include <bits/stdc++.h>

using namespace std;

const int N = 100000;

int n, p[N + 10];
long long s[N + 10];
long long res;

long long sum(int i, int j) {
    return s[j] - s[i-1];
}

int main() {
    //freopen("input.txt", "r", stdin);
    scanf("%d", &n);
    for(int i = 1; i <= n; i++) {
        int x;
        scanf("%d", &x); s[i] = s[i-1] + x;
    }
    int ss = trunc(sqrt(n));
    for(int i = 2; i <= ss; i++) if (!p[i])
        for(int j = i*i; j <= n; j += i) p[j] = i;
    for(int i = 2; i <= n; i++) if (!p[i]) res += sum(n-i+1, n) - sum(1, i);
    cout << res;
}
