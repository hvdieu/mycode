#include <bits/stdc++.h>

using namespace std;

const int N = 3000 + 10;
const int MAX = 1e7 + 10;


int n, a[N];
long long dp[MAX], ans;
int cnt[MAX];



void init() {
    sort(a, a+n);
    int m = 1;
    cnt[a[0]] = 1;
    for(int i = 1; i < n; i++) {
        cnt[a[i]]++;
        if (a[i] - a[i-1]) a[m++] = a[i];
    }
    n = m;
}

long long C2(long long n) {
    return (n-1)*n/2;
}

long long C3(long long n) {
    return n*(n-1)*(n-2) / 6;
}

long long C4(long long n) {
    return n*(n-1)*(n-2)*(n-3) / 24;
}

void solve() {
    for(int i = 0; i < n; i++)
        for(int j = i+1; j < n; j++)
            if (a[i] + a[j] < MAX) {
                dp[a[i] + a[j]] += cnt[a[i]] * cnt[a[j]];
            }
    for(int i = 0; i < n; i++)
        if (a[i]*2 < MAX)
            dp[a[i]*2] += C2(cnt[a[i]]);
    for(int i = 0; i < n; i++) {
        cout << a[i] << ' ' << dp[a[i]] << ' ' << cnt[a[i]] << "\n";
        ans += C2(dp[a[i]]) * C2(cnt[a[i]]);
        cout << ans << "\n";
    }

    for(int i = 0; i < n; i++)
        for(int j = i+1; j < n; j++)
        if (a[i] + a[j] < MAX && cnt[a[i]] > 1 && cnt[a[j]] > 1) {
            ans -= (cnt[a[i]] * C2(cnt[a[j]]) + cnt[a[j]] * C2(cnt[a[i]]) + C2(cnt[a[i]]) * C2(cnt[a[j]])) * C2(cnt[a[i] + a[j]]);
        }
    for(int i = 0; i < n; i++)
        if (a[i]*2 < MAX) {
            ans -= C2(cnt[a[i]*2]) * C4(cnt[a[i]]) * 3;
            cout << ans << ' ';
            ans -= C3(cnt[a[i]]) * 3;
            cout << ans << ' ';
        }
    //cout << dp[5] << ' ' << cnt[5] << "\n";
}

int main() {
    ios_base::sync_with_stdio(false);
    freopen("in.txt", "r", stdin);
    cin >> n;
    for(int i = 0; i < n; i++) cin >> a[i];
    init();
    solve();
    cout << ans;
}
