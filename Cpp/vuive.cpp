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
#define two(i) (ll(1) << i)
#define N 110
#define T 25010

int n, time, a1[N], b1[N], t1[N], a2[N], b2[N], t2[N], top1, top2;
ll f[N][T], g[T];

void Dp1() {
    For(i, 1, top1) For(time, 1, 25000) {
        f[i][time] = max(f[i-1][time], f[i][time-1]);
        ll sum = 0;
        For(k, 1, 1000) if (a1[i] - (k-1) * (k-1) * b1[i] <= 0 || t1[i]*k > time) break;
        else {
            sum += a1[i] - (k-1) * (k-1) * b1[i];
            f[i][time] = max(f[i][time], f[i-1][time - t1[i]*k] + sum);
        }
    }
}

void Dp2() {
    For(time, 1, 25000) {
        g[time] = max(g[time-1], f[n][time]);
        For(i, 1, top2) if (time >= t2[i])
        g[time] = max(g[time], g[time - t2[i]] + a2[i]);
    }
}

int main() {
    freopen("vuive.inp","r",stdin);
    freopen("vuive.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        int a, b, t;
        scanf("%d%d%d", &a, &b, &t);
        if (a) {
            if (b) {
                a1[++top1] = a; b1[top1] = b; t1[top1] = t;
            } else {
                a2[++top2] = a; b2[top2] = b; t2[top2] = t;
            }
        }
    }
    Dp1();
    Dp2();
    int ntest;
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &time);
        cout << g[time] << endl;
    }
}
