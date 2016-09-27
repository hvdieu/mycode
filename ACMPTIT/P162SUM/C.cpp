#include <bits/stdc++.h>

using namespace std;

string s;
int n, m;
long long ans;

int main() {
   // ifstream cin("in.txt");
    cin >> n >> m;
    cin >> s;
    ans = n*m - n;
    for(int i = 1; i < n; i++)
        if (s[i] != s[i-1]) ans += n*m - n;
    long long len = 1;
    for(int i = 1; i < n; i++)
        if (len == 1) {
            if (s[i] == s[i-1]) continue;
            else len++;
        } else {
            if (s[i] == s[i-2]) len++;
            else {
                ans -= (len * (len-1))/2;
                if (s[i] == s[i-1]) len = 1;
                else len = 2;
            }
        }
    ans -= (len * (len-1)) / 2;
    cout << ans;
}
