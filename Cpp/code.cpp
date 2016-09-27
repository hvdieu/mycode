#include <iostream>

using namespace std;

int n, k, res;
int cnt[5];
int a[11];

void Khuyen(int i) {
    if (i > 10) {
        res++;
        return;
    }
    for(int j = 0; j < 5; j++) if (cnt[j] && j != a[i-1]) {
        a[i] = j; cnt[j]--;
        Khuyen(i+1);
        cnt[j]++;
    }
}

int main() {
    res = 0
    double x = 0;
    for(int i = 0; i <= 10; i++) {
        x = x * 0.75 + 200;
    }
    cout << x;
}
