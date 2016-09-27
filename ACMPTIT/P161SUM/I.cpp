#include <bits/stdc++.h>

using namespace std;

int n, k;
string s;
int cnt[26];
long long ans;

int main() {
   // ifstream cin("in.txt");
    cin >> n >> k;
    cin >> s;
    for(int i = 0; i < n; i++) cnt[s[i] - 'A']++;
    sort(cnt, cnt+26);
    for(int i = 25; i >= 0; i--) {
        long long tmp = min(k, cnt[i]);
        ans += tmp*tmp;
        k -= tmp;
    }
    cout << ans;
}
