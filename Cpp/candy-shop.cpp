#include <bits/stdc++.h>

using namespace std;

const int N = 250 + 10;
const int a[7] = {1, 2, 5, 10, 20, 50, 100};

int n;
long long f[N];

int main() {
    //freopen("input.txt", "r", stdin);
    cin >> n;
    f[0] = 1;
        for(int j = 0; j < 7; j++)
            for(int i = 1; i <= n; i++) if (i >= a[j]) f[i] += f[i-a[j]];
    cout << f[n];
}
