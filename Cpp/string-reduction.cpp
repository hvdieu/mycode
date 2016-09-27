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
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 110

char s[N];
int a[N];
int n, ntest, f[N][N][N];

int cal(int a, int b, int c) {
    if (f[a][b][c] > 0) return f[a][b][c];
    if (!a) return (f[a][b][c] = cal(1, b-1, c-1));
    if (!b) return (f[a][b][c] = cal(a-1, 1, c-1));
    if (!c) return (f[a][b][c] = cal(a-1, b-1, 1));
    return (f[a][b][c] = min(min(cal(a-1, b-1, c+1), cal(a+1, b-1, c-1)), cal(a-1, b+1, c-1)));
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d\n", &ntest);
    reset(f, 0xff);
    For(i, 1, 100) {
        f[i][0][0] = i;
        f[0][i][0] = i;
        f[0][0][i] = i;
    }
    while (ntest) {
        ntest--;
        scanf("%s\n", s+1);
        int sa = 0, sb = 0, sc = 0;
        n = strlen(s+1);
        For(i, 1, n) if (s[i] == 'a') sa++; else if (s[i] == 'b') sb++; else sc++;
        printf("%d\n", cal(sa, sb, sc));
    }
}




