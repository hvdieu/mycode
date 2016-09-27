#include <bits/stdc++.h>

using namespace std;

int ntest, n;
double sum;
bool flag, fail;

int main() {
    //ifstream cin("in.txt");
    cin >> ntest;
    while (ntest--) {
        cin >> n;
        sum = 0; flag = false; fail = true;
        for(int i = 0; i < n; i++) {
            int x; cin >> x; sum += x;
            fail &= (x > 2);
            flag |= (x == 5);
        }
        cout << ((flag && fail && (sum / n >= 4)) ? "Yes\n" : "No\n");
    }
}
