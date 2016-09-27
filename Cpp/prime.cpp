#include <cstring>
#include <iostream>
#include <stdio.h>
#include <vector>
#include <algorithm>
#include <math.h>
#include <cmath>
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
#define N 1299710

int p[N], n;
vector<int> prime;

int main() {
   // freopen("prime.inp","r",stdin);
   // freopen("prime.out","w",stdout);
    int ss = int(sqrt(double(N)));
    p[1] = 1;
    For(i, 2, ss) if (!p[i]) {
        for(int j = i*i; j <= N-1; j += i) p[j] = 1;
    }
    For(i, 2, N-1) if (!p[i]) prime.pb(i);
    while (1) {
        scanf("%d", &n);
        if (!n) break;
        if (!p[n]) printf("0\n");
        else {
            int x = upper_bound(all(prime), n) - prime.begin();
            printf("%d\n", prime[x]-prime[x-1]);
        }
    }
}
