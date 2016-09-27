#include <bits/stdc++.h>

using namespace std;

int ntest, n;
string s;

int main() {
    //ifstream cin("input.txt");
    cin >> ntest;
    while (ntest-- > 0) {
        cin >> n;
        cin >> s;
        int R = 0, G =  0, B = 0;
        for(int i = 0; i < s.size(); i++)
            if (s[i] == 'R') R++;
            else if (s[i] == 'G') G++;
            else B++;
        cout << min(n - R, min(n - G, n - B)) << "\n";
    }
}
