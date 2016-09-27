#include <bits/stdc++.h>

using namespace std;

int ntest;
long long R, G, B, K;

int main() {
    //ifstream cin("input.txt");
    cin >> ntest;
    while (ntest-- > 0) {
        cin >> R >> G >> B >> K;
        cout << min(K-1, R) + min(K-1, G) + min(K-1, B) + 1 << "\n";
    }
}
