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
#define N 10010

int ntest, n, a[N], sum, m;

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        sum = m = 0;
        For(i, 1, n) {
            scanf("%d", a+i);
            sum += a[i];
            if (a[i]) m++;
        }
        bool flag;
        if (sum < 100) flag = false;
        else if (sum == 100) flag = true;
        else {
            sum -= 100;
            if (sum < m) flag = true;
            else flag = false;
        }
        if (flag) cout << "YES" << endl;
        else cout << "NO" << endl;
    }
}




