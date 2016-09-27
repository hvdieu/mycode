#include <cstring>
#include <vector>
#include <list>
#include <map>
#include <set>
#include <queue>
#include <deque>
#include <stack>
#include <bitset>
#include <algorithm>
#include <functional>
#include <numeric>
#include <utility>
#include <sstream>
#include <fstream>
#include <iostream>
#include <iomanip>
#include <cstdio>
#include <cmath>
#include <climits>
#include <cstdlib>
#include <ctime>
#include <memory.h>
#include <cassert>

#define FOR(i, a, b) for(int i = (a); i < (b); ++i)
#define REP(i, a, b) for(int i = (a); i <=(b); ++i)
#define REPD(i, a, b) for(int i = (a); i >=(b); --i)
#define TR(it, a) for(typeof(a.begin()) it = a.begin(); it != a.end(); ++it)
#define RESET(a, v) memset(a, (v), sizeof(a))
#define SZ(a) (int(a.size()))
#define ALL(a) a.begin(), a.end()
#define PB push_back
#define MP make_pair
#define LL long long
#define LD long double
#define II pair<int, int>
#define X first
#define Y second
#define VI vector<int>
#define VII vector<II>
#define endl '\n'

const int N = 5050;
const int INF = 1000000009;

using namespace std;

int minPage[N],lastPackable[N];
int G[N][N], F[N][N];
int a[N];
int n, L, P;

void minimize(int &a, int b) {a = a > b ? b : a;}

void readInput() {
    ios :: sync_with_stdio(0); cin.tie(0);
    freopen("input.txt", "r", stdin);
    cin >> n >> L >> P;
    REP(i, 1, n) cin >> a[i];
}

void initialize() {
    int len = 0, line = 1, page = 1;
    REP(i, 1, n) {
        len += a[i];
        if (len > L) {
            len = a[i];
            ++line;
        }
        if (line > P) {
            line -= P;
            ++page;
        }
        minPage[i] = page;
        //cout << i << ' d' << len << ' ' << line << ' ' << page << endl;
        lastPackable[page] = i;
    }
    RESET(G, -1);
    REP(i, 1, n) {
        int len = 0, line = 1, page = 1;
        REP(j, i, n) {
            len += a[j];
            if (len > L) {
                len = a[j];
                ++line;
            }
            if (line > P) {
                line -= P;
                ++page;
            }
            if (page > 1) break;
            int cost = L;
            G[i][j] = INF;
            REPD(k, j, i) {
                cost -= a[k];
                if (cost < 0) break;
                minimize(G[i][j], max(G[i][k - 1], cost));
            }
        }
    }
}

int dp(int i, int p) {
    int &ans = F[i][p];
    if (ans >= 0) return ans;
    ans = G[1][i] >= 0 ? G[1][i] : INF;
    if (p == 1) return ans;
    REPD(j, min(i - 1, lastPackable[p - 1]), 1)
    if (G[j + 1][i] >= 0)
        minimize(ans, dp(j, p - 1) + G[j + 1][i]);
    else break;
    return ans;
}

int main() {
    readInput();
    initialize();
    RESET(F, -1);
    cout << minPage[n] << endl;
    cout << dp(n, minPage[n]) << endl;
    return 0;
}
