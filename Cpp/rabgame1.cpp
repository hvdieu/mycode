#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#include <queue>
#include <stack>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 160
#define BASE 100000000

struct bignum {
    int h[50];
};

int n,k;
bignum f[N],c[N][N],gt[N];

bignum operator + (const bignum &a, const bignum &b) {
    bignum c;
    c.h[0] = max(a.h[0],b.h[0]);
    int nho = 0;
    For(i,1,c.h[0]) {
        int x = nho;
        if (i <= a.h[0]) x += a.h[i];
        if (i <= b.h[0]) x += b.h[i];
        c.h[i] = x % BASE;
        nho = x / BASE;
    }
    if (nho) {
        c.h[0]++; c.h[c.h[0]] = nho;
    }
    return c;
}

bignum operator * (const bignum &a,const bignum &b) {
    bignum res;
    ll c[50];
    memset(c,0,sizeof(c));
    c[0] = a.h[0] + b.h[0] - 1;
    For(i,1,a.h[0])
      For(j,1,b.h[0])
        c[i+j-1] += ll(a.h[i])*b.h[j];
    ll nho = 0;
    For(i,1,c[0]) {
        ll x = c[i] + nho;
        nho = x / BASE;
        c[i] = x % BASE;
    }
    if (nho) {
        c[0]++; c[c[0]] = nho;
    }
    res.h[0] = c[0];
    For(i,1,c[0]) res.h[i] = c[i];
    return res;
}

void ghi(bignum a) {
    cout << a.h[a.h[0]];
    Rep(i,a.h[0]-1,1) {
        int x = a.h[i], len = 0;
        while (x > 0) {
            len++; x /= 10;
        }
        len = 8-len;
        while (len) {
            cout << 0; len--;
        }
        if (a.h[i]) cout << a.h[i];
    }
    cout << "\n";
}

int main() {
   // freopen("rabgame1.inp","r",stdin);
   // freopen("rabgame1.out","w",stdout);
    cin >> n >> k;
    f[0].h[0] = 1; f[0].h[1] = 1;
    For(i,0,n)
     For(j,0,n) {
        c[i][j].h[0] = 1; c[i][j].h[1] = 0;
     }
    For(i,0,n) {
        c[0][i].h[0] = 1;
        c[0][i].h[1] = 1;
    }
    For(j,1,n)
      For(i,1,j) c[i][j] = c[i-1][j-1] + c[i][j-1];
    gt[0].h[0] = 1; gt[0].h[1] = 1;
    For(i,1,n) {
        bignum x;
        x.h[0] = 1; x.h[1] = i;
        gt[i] = gt[i-1] * x;
    }
    For(i,1,n) {
        f[i] = f[i-1];
        For(j,2,min(k,i))
         if (k % j == 0) {
            bignum x = f[i-j]*c[j-1][i-1];
            x = x * gt[j-1];
            //if (i == 17) {
          //      ghi(f[i-j]);
          //      ghi(c[j-1][i-1]);
         //       ghi(x);
        //    }
            f[i] = f[i] + x;
           // if (i== 17) {
           //     ghi(f[i]); printf("\n");
          //  }
         }
    }
    //For(i,1,n) ghi(f[i]);
    //ghi(c[0][17]);
    ghi(f[n]);
    //cout << f[n].h[f[n].h[0]];
}



