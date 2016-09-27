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
#define N 1010

int n, m;
char s[N][N];
bool bigger[N];

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d\n", &m ,&n);
    int res = 0;
    For(i, 1, m) scanf("%s\n", s[i]+1);
    For(j, 1, n) {
        bool flag = true;
        For(i, 2, m) if (s[i-1][j] <= s[i][j] || (s[i-1][j] > s[i][j] && bigger[i])) continue;
        else flag = false;
        if (!flag) res++;
        else For(i, 2, m) if (s[i][j] > s[i-1][j]) bigger[i] = true;
    }
    cout << res;
}




