#include <iostream>
#include <stdio.h>
#include <cstring>
using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 31

struct matrix {
    int h[N][N];
};

matrix A, one, res;
int n, k, BASE;

matrix operator *(const matrix &A, const matrix &B) {
    matrix C;
    reset(C.h, 0);
    For(i, 1, n) For(j, 1, n) {
        ll x = 0;
        For(t, 1, n) x += A.h[i][t] * B.h[t][j];
        C.h[i][j] = x % BASE;
    }
    return C;
}

matrix operator +(const matrix &A, const matrix &B) {
    matrix C;
    For(i, 1, n) For(j, 1, n) C.h[i][j] = (A.h[i][j] + B.h[i][j]) % BASE;
    return C;
}

matrix mu(matrix A, int n) {
    matrix res = one;
    while (n) {
        if (n & 1) res = res * A;
        n >>= 1;
        A = A * A;
    }
    return res;
}

matrix cal(matrix A, int n) {
    if (n == 1) return A;
    matrix B = cal(A, n/2);
    matrix C = mu(A, (n+1)/2);
    matrix D = C * B;
    if (n % 2 == 0) return B + D;
    else return (B + D) + C;
}

int main() {
  //  freopen("matrix.inp","r",stdin);
 //   freopen("matrix.out","w",stdout);
    scanf("%d%d%d", &n, &k, &BASE);
    For(i, 1, n) For(j, 1, n) scanf("%d", &A.h[i][j]);
    reset(one.h, 0);
    For(i, 1, n) one.h[i][i] = 1;
    res = cal(A, k);
    For(i, 1, n) {
        For(j, 1, n) printf("%d ", res.h[i][j]);
        printf("\n");
    }
}
