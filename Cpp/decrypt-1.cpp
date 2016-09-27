#include <bits/stdc++.h>

using namespace std;

const int N = 100 + 10;

int n, ntest;
string P, E;

string shift(string P, int width) {
    string E;
    for(int i = 0; i < P.size(); i++) {
        int c = P[i] - width;
        if (c < 'a') c += 26;
        E.push_back(char(c));
    }
    return E;
}

int countDif(string P, string E) {
    int diff = 0;
    for(int i = 0; i < P.size(); i++) diff += (P[i] != E[i]);
    return diff;
}

int main() {
    //freopen("input.txt", "r", stdin);
    cin >> ntest;
    for(int iTest = 1; iTest <= ntest; iTest++) {
        cin >> P; cin >> E;
        int res = N;
        for(int width = 0; width < 26; width++) res = min(res, countDif(shift(P, width), E));
        cout << res << endl;
    }
}
