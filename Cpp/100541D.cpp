#include <algorithm>
#include <deque>
#include <iostream>
#include <list>
#include <map>
#include <queue>
#include <set>
#include <string>
#include <stack>
#include <sstream>
#include <vector>

#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>

#define FOR(i, a, b) for(int i = a; i <= b; ++i)
#define FRD(i, a, b) for(int i = a; i >= b; --i)
#define FR(i, a) for(int i = 0; i < a; ++i)
#define REP(i, a) for(int i = 0; i <= a; ++i)
#define pb push_back
#define sz(x) (int)x.size()
#define reset(a, b) memset(a, b, sizeof a)
#define bug(x) cout << #x << " = " << x << endl
#define bg(a, m, n) FOR(i, m, n) cout << a[i] << " "; cout << endl
using namespace std;

typedef long long ll;
typedef unsigned long long qword;

int n, k;
int sum[105];
int id[100];

int main() {
#ifndef ONLINE_JUDGE
    freopen("input.txt", "r", stdin);
#endif
    int nTests = 0; scanf("%d", &nTests);
    while (nTests--) {
        scanf("%d%d", &n, &k);
        sum[0] = 0; reset(id, 0);
        int cnt = 0;
        int x = n % 100;
        if (x == 0) {
            printf("%d\n", n);
        }
        else {
            do {
                if (id[x]) break;
                id[x] = ++cnt; sum[cnt] = sum[cnt-1] + x;
                x = (x + x) % 100;
            } while (true);
            if (k <= id[x]) printf("%I64d\n", (ll)n + sum[k]);
            else {
                int l = id[x], r = cnt;
                ll res = n + sum[id[x] - 1];
                k -= id[x];
                int len = r - l + 1;
                int sl = k / len;
                res += (ll)sl * (sum[r] - sum[l-1]);
                res += (ll)sum[l + k % len] - sum[l-1];
                printf("%I64d\n", res);
            }
        }
    }
    return 0;
}
