#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
#include <queue>
#include <stack>

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
#define N 110

int ntest, n, p[N], m, trace[N][N], seq[N], dem;
ll f[N][N];

void init() {
    For(i, 2, 100) {
        bool flag = true;
        For(j, 2, i-1) if (i % j == 0) flag = false;
        if (flag) p[++m] = i;
    }
}

int main() {
    freopen("shuffle.inp","r",stdin);
    freopen("shuffle.out","w",stdout);
    init();
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        reset(f, 0); reset(trace, 0);
        f[0][0] = 1;
        For(i, 1, m) For(j, 0, n) {
            f[i][j] = f[i-1][j]; trace[i][j] = 0;
            int x = 1;
            For(k, 1, 64) {
                x = x * p[i];
                if (x > j) break;
                if (f[i][j] < f[i-1][j-x] * x) {
                    f[i][j] = f[i-1][j-x] * x;
                    trace[i][j] = x;
                }
            }
        }

        int res = 0, j = 0, i = m, sum = 0, dem = 0;
        For(jj, 0, n) if (f[m][jj] > res) {
            res = f[m][jj]; j = jj;
        }
        printf("%d ", res);
        while (i) {
            sum += trace[i][j];
            if (trace[i][j]) seq[++dem] = trace[i][j];
            j -= trace[i][j]; i--;
        }
        while (sum < n) {
            seq[++dem] = 1; sum++;
        }
        sort(seq+1, seq+dem+1);
        For(i, 1, dem) cout << seq[i] << ' ';
        int x = 0;
        For(i, 1, dem) {
            int len = seq[i];
            x += seq[i];
          //  For(j, x - len + 2, x) printf("%d ", j);
            //printf("%d ", x - len + 1);
        }
        printf("\n");
    }
}
