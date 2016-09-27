#include <bits/stdc++.h>

using namespace std;

string s;
long long l, ans;
int n;

int main() {
   // freopen("in.txt", "r", stdin);
    cin >> s;
    cin >> l;
    n = s.size();
    int a = 0;
    for(int i = 0; i < n; i++) {
        if (s[i] == 'a') {
            a++;
            if (i < (l % n)) ans++;
        }
    }
    ans += a * (l / n);
    cout << ans;
}
