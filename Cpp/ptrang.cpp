#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 5010
#define inf 1000000000

struct node {
    int curLine, curMax, remain;
};

node make_node(int _curLine, int _curMax, int _remain) {
    node e;
    e.curLine = _curLine;
    e.curMax = _curMax; e.remain = _remain;
    return e;
}

bool operator < (const node &a, const node &b) {
    if (a.curLine != b.curLine) return a.curLine < b.curLine;
    if (a.curMax != b.curMax) return a.curMax < b.curMax;
    return a.remain < b.remain;
}

int n, L, P, a[N], minPage[N], MIN, bound;
map<node, int> f[N][50];
map<node, int>::iterator it;

inline int cal_min_page(int u) {
    MIN = 0;
    int numPage = 0, remain = 0, line = P, MAX = 0;
    For(i, u, n) if (remain < a[i]) {
        MAX = max(MAX, remain);
        remain = L - a[i];
        line++;
        if (line > P) line = 1, numPage++, MIN += MAX, MAX = 0;
    } else remain -= a[i];
    MAX = max(MAX, remain);
    MIN += MAX;
    return numPage;
}

int dp(int i, int curPage, int curLine, int curMax, int remain) {

    if (i > n) return max(remain, curMax);
    node tt = make_node(curLine, curMax, remain);
    it = f[i][curPage].find(tt);
    if (it != f[i][curPage].end()) return it->se;
    int res = inf, x;
    if (remain >= a[i]) res = dp(i+1, curPage, curLine, curMax, remain - a[i]);
    if (res != inf && res > MIN) {
        f[i][curPage][tt] = inf;
        return inf;
    }
    if (curLine < P && (n < 500 || (n >= 500 && remain < a[i] || remain < bound))) {x = dp(i+1, curPage, curLine+1, max(curMax, remain), L - a[i]); if (x < res) res = x;}
    if (curPage + minPage[i] <= minPage[1] && (minPage[1] <= 20 || (minPage[1] > 20 && curLine > P/4))) {x = dp(i+1, curPage+1, 1, 0, L - a[i]) + max(remain, curMax); if (x < res) res = x;}
    f[i][curPage][tt] = res;
    return res;
}

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d%d%d", &n, &L, &P);
    int maxa = 0;
    For(i, 1, n) {
        scanf("%d", a+i); maxa = max(maxa, a[i]);
    }
    //cal_min_page(1);
    if (L > 50) { if (n == 5000) bound = 8; else bound = 10; }
    else if (L > 20) bound = L / 3;
    else if (bound > 10) bound = L / 2;
    else bound = L;
    Rep(i, n, 1) minPage[i] = cal_min_page(i);
    //cout << MIN << endl;
    cout << dp(1, 1, 1, 0, L);
}
