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
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 100010
#define T 1000021

int n, a[N], dem[N], res, f[N], m;
int t[T][20];

int val(string s) {
    int num = 0;
    For(i, 0, sz(s)-1) num = num * 10 + int(s[i]) - int('0');
    return num;
}

void sub1() {
    a[0] = -1;
    dem[n+1] = dem[n];
    a[n+1] = 1000000000;
    For(i, 1, n+1) if (a[i] >= 0) {
        For(j, 0, i-1) if (!j || (a[j] >= 0 && a[j] < a[i])) {
            int x;
            if (!j) x = dem[i]; else x = dem[i] - dem[j-1];
            x = min(x, a[i] - a[j] - 1);
            x++;
            f[i] = max(f[i], f[j] + x);
        }
    }
    cout << f[n+1] - 1;
}

int get(int i, int j) {
    if (i < 0) return -100000;
    int s = 0;
    for(i; i; i -= i & (-i)) s = max(s, t[i][j]);
    return s;
}

void update(int i, int j, int val) {
    for(i; i <= T-1; i += i & (-i)) t[i][j] = max(t[i][j], val);
}

void sub2() {
    a[n+1] = T-1;
    For(i, 1, n+1) if (a[i] < 0) {
        m++;
        For(x, 1, T-1) t[x][m] = t[x][0];
    } else {
        f[i] = get(a[i]-1, 0) + 1;
        For(j, 1, m) f[i] = max(f[i], get(a[i]-1-j, m-j+1) + j + 1);
        update(a[i], 0, f[i]);
    }
    cout << f[n+1] - 1;
}

int main() {
    freopen("seqb2.inp","r",stdin);
    freopen("seqb2.out","w",stdout);
    scanf("%d\n", &n);
    For(i, 1, n) {
        dem[i] = dem[i-1];
        string s;
        cin >> s;
        if (s == "*") {
            a[i] = -1;
            dem[i]++;
        }
        else a[i] = val(s);
        if (a[i] > 0) a[i]++;
    }
   if (n <= 1000) sub1(); else
    sub2();
}
