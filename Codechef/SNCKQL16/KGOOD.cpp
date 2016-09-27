#include <bits/stdc++.h>

using namespace std;

int ntest, k, cnt[26];
string s;

void solve() {
    sort(cnt, cnt+26);
    int sum = 0, ans = s.size();
    for(int i = 0; i < 26; i++) if (cnt[i]) {
        int tmp = 0;
        for(int j = i+1; j < 26; j++)
            if (cnt[j] - cnt[i] > k)
                tmp += cnt[j] - cnt[i] - k;
        ans = min(ans, tmp + sum);
        sum += cnt[i];
    }
    cout << ans << "\n";
}

int main() {
    //ifstream cin("in.txt");
    cin >> ntest;
    while (ntest--) {
        cin >> s >> k;
        memset(cnt, 0, sizeof cnt);
        for(int i = 0; i < s.size(); i++) cnt[s[i] - 'a']++;
        solve();
    }
}
