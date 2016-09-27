#include <bits/stdc++.h>

using namespace std;

const int N = 1e5 + 10;

int n, k;
string s;
bool was[N];

int main() {
    cin >> n >> k;
    cin >> s;
    for (int i = 0; i < n / 2; i++) {
        int j = n - i - 1;
        if (s[i] != s[j]) {
            k--;
            if (s[i] > s[j]) s[j] = s[i];
            else s[i] = s[j];
            was[i] = was[j] = true;
        }
    }
    if (k < 0) {
        cout << -1;
        return 0;
    }
  //  cout << s << ' '<< k << "\n";
    for (int i = 0; i < n/2; i++) {
        if (was[i]) k++;
        if (s[i] != '9' && k > 1) {
            s[i] = s[n-i-1] = '9', k -= 2;
        } else if (was[i]) k--;
       // cout << s << ' ' << k << "\n";
    }
    if (n % 2 == 1 && k > 0) s[n/2] = '9';
    cout << s;
}
