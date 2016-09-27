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
#define N 100010

int n, a[N], s[N][2], dem;
ii res[N];

bool cmp(ii a, ii b) {
    if (a.fi != b.fi) return a.fi < b.fi;
    return a.se < b.se;
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("B.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i]);
        a[i]--;
        s[i][0] = s[i-1][0];
        s[i][1] = s[i-1][1];
        s[i][a[i]]++;
    }
    For(t, 1, n) {
        int game1 = 0, game2 = 0;
        bool flag = true;
        int first = 1;
        while (first <= n) {
            int d = first, c = n, mid, ans = -1;
            while (d <= c) {
                mid = (d + c) / 2;
                if (max(s[mid][0] - s[first-1][0], s[mid][1] - s[first-1][1]) >= t) {
                    ans = mid; c = mid - 1;
                } else d = mid + 1;
            }
            if (ans == -1) {
                flag = false; break;
            } else {

                if (s[ans][0] - s[first-1][0] == t) game1++;
                else game2++;
                first = ans + 1;
            }
        }
        if (flag) {
            if (a[n] == 0 && game1 > game2) res[++dem] = ii(game1, t);
            else if (a[n] == 1 && game2 > game1) res[++dem] = ii(game2, t);
        }
    }
    sort(res+1, res+dem+1, cmp);
    printf("%d\n", dem);
    For(i, 1, dem) printf("%d %d\n", res[i].fi, res[i].se);
}




