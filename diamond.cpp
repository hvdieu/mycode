#include <bits/stdc++.h>

using namespace std;

const int N = 100000 + 10;

int a[N], n, ans, k;

int main() {
    ifstream cin("diamond.in");
    ofstream cout("diamond.out");
    cin >> n >> k;
    for(int i = 0; i < n; i++) cin >> a[i];
    sort(a, a+n);
    int j = 0;
    for(int i = 0; i < n; i++) {
        while (j < n-1 && a[j+1] - a[i] <= k) j++;
        ans = max(ans, j-i+1);
    }
    cout << ans;
}
