#include <bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef vector<int> bignum;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i--)
#define sz(x) int(x.size())
#define all(x) x.begin(), x.end()
#define N 182
#define BASE 100000000

int n;
bignum f[N][61][61];

bool check(int numA, int numB, int numC) {
    if (numA >= numB && numB >= numC) return true;
    return false;
}

bignum operator + (bignum A, bignum B) {
    bignum C; C.clear();
    int n = max(sz(A), sz(B)), nho = 0;
    For(i, 0, n-1) {
        int x = nho;
        if (i < sz(A)) x += A[i];
        if (i < sz(B)) x += B[i];
        C.push_back(x % BASE);
        nho = x / BASE;
    }
    if (nho) C.push_back(nho);
    return C;
}

void ghi(bignum a) {
    int n = sz(a);
    cout << a[n-1];
    Rep(i, n-2, 0) {
        int len = 0, x = a[i];
        while (x) {
            len++; x /= 10;
        }
        For(j, 1, 8-len) cout << 0;
        cout << a[i];
    }
    cout << endl;
}

int main() {
    //freopen("input.txt","r", stdin);
  //  freopen("output.txt", "w", stdout);
    f[0][0][0].push_back(1);
    For(i, 0, 180-1) For(numA, 0, 60) For(numB, 0, 60) {
        int numC = i - numA - numB;
        if (numA >= numB && numB >= numC) {
            if (check(numA+1, numB, numC)) f[i+1][numA+1][numB] = f[i+1][numA+1][numB] + f[i][numA][numB];
            if (check(numA, numB+1, numC)) f[i+1][numA][numB+1] = f[i+1][numA][numB+1] + f[i][numA][numB];
            if (check(numA, numB, numC+1)) f[i+1][numA][numB] = f[i+1][numA][numB] + f[i][numA][numB];
        }
    }
    while (scanf("%d", &n) != -1) {
        ghi(f[n*3][n][n]);
        //cout << f[n*3][n][n];
        cout << endl;
    }
}
