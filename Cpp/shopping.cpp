#include <bits/stdc++.h>

using namespace std;

const int N = 3000 + 10;

int n, m, k, T, MIN;
double dp[N][8000];
double ans[N];
int a[6], b[6];
vector<int> stt;
bool ok;

void analyse(int x) {
    MIN = m+1;
    ok = true;
    for(int i = 1; i <= k; i++) a[i] = x % (m+1), x /= m+1, MIN = min(MIN, a[i]);
    for(int i = 2; i <= k; i++) if (a[i] < a[i-1]) ok = false;
}

int convert() {
    for(int i = 1; i <= k; i++) b[i] = a[i];
    sort(b+1, b+k+1);
    int pw = 1;
    int res = 0;
    for(int i = 1; i <= k; i++) {
        int x = b[i];
        res += x * pw;
        pw *= m+1;
    }
    return res;
}

int main() {
   // freopen("input.txt", "r", stdin);
    cin >> n >> m >> k;
    dp[1][0] = 1;
    T = pow(m+1, k);
    for(int tt = 0; tt < T; tt++) {
        analyse(tt);
        if (ok) stt.push_back(tt);
    }
    for(int i = 1; i <= n; i++) {
        ans[i] += ans[i-1];
        for(int tt : stt) {
            analyse(tt);
            ans[i] += dp[i][tt] * MIN;
            for(int j = 1; j <= k; j++) a[j] -= MIN;
            for(int j = 1; j <= k; j++) if (!a[j]) {
                for(int time = 1; time <= m; time++) {
                    a[j] = time;
                    int newtt = convert();
                    dp[i+1][newtt] += dp[i][tt] / m;
                }
                break;
            }
        }
    }

    for(int i = 1; i <= n; i++) printf("%.4f\n", ans[i]);
}
