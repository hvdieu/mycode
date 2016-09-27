#include <bits/stdc++.h>

using namespace std;

const int N = 1e5 + 10;
const int inf = 2e9;

int ntest, n;
long long x[N];
char avail[N];
long long ans;

int main() {
    //ifstream cin("in.txt");
    cin >> ntest;
    while (ntest--) {
        cin >> n;
        cin >> (avail+1);
        avail[0] = avail[n+1] = '1';
        for(int i = 1; i <= n; i++) cin >> x[i];
        x[0] = -inf; x[n+1] = inf;
        ans = 0;
        for(int i = 0; i <= n; ) {
            long long MAX = 0;
            for(int j = i+1; j <= n+1; j++) {
                MAX = max(x[j] - x[j-1], MAX);
                if (avail[j] == '1') {
                    ans += x[j] - x[i] - MAX;
                    //cout << x[i] << ' ' << x[j] << ' ' << MAX << ' ' << ans << "\n";
                    i = j;
                    break;
                }
            }
        }
        cout << ans << "\n";
    }
}
