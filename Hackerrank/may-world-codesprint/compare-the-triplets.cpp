#include <bits/stdc++.h>

using namespace std;

int main() {
    int a = 0, b = 0;
    int x[3], y[3];
    for(int i = 0; i < 3; i++) cin >> x[i];
    for(int i = 0; i < 3; i++) cin >> y[i];
    for(int i = 0; i < 3; i++) {
        if (x[i] > y[i]) a++;
        if (x[i] < y[i]) b++;
    }
    cout << a << ' ' << b;
}
