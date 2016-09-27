#include <bits/stdc++.h>
#define N 100010

int a[N];
bool dd[N];

using namespace std;

int main() {
    //freopen("input.txt", "r", stdin);
    int ntest;
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        int n, m;
        scanf("%d%d\n", &n, &m);
        if (__gcd(m, n) == 1) cout << "Yes" << endl;
        else cout << "No " << n / __gcd(m, n) << endl;
    }
}
