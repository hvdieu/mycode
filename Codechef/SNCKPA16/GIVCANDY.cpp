#include <bits/stdc++.h>

using namespace std;

long long A, B, C, D, ans;
int ntest;

long long gcd(long long a, long long b) {
    if (!b) return a;
    return gcd(b, a % b);
}

int main() {
    //freopen("in.txt", "r", stdin);
    cin >> ntest;
    while (ntest--) {
        cin >> A >> B >> C >> D;
        long long E = gcd(C, D);
        long long F = abs(A - B) % E;
        cout << min(abs(F), abs(E-F)) << "\n";
    }
}
