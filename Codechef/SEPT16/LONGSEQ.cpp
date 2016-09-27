#include <bits/stdc++.h>

using namespace std;

int ntest;
string s;

int main() {
    //freopen("in.txt", "r", stdin);
    cin >> ntest;
    while (ntest--) {
        cin >> s;
        int cnt = 0;
        for(int i = 0; i < s.size(); i++)
            cnt += s[i] - '0';
        if (cnt == 1 || cnt == s.size() - 1)
            cout << "Yes\n";
        else
            cout << "No\n";
    }
}
