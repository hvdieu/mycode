#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define reset(f, x) memset(f, x, sizeof(f))
#define sz(x) int(x.size())
#define N 1001

struct node {
    int val, ch, j;
    node (int _val, int _ch, int _j) {
        val = _val; ch = _ch; j = _j;
    }
};

bool operator > (const node &a, const node &b) {
    return a.val > b.val;
}

int n, a[N], len, m, f[26][252];
vector< vector<int> > l[26];
vector<int> b;
char s[N];
priority_queue<node, vector<node>, greater<node> > heap;

int count(int j, vector<int> b, int tt) {
    int i = tt;
    while (j < m && i < sz(b)) if (a[j+1] == b[i++]) j++;
    return j;
}

void solve() {
   // cout << sz(heap) << endl;
    while (!heap.empty()) {
        int val = heap.top().val, ch = heap.top().ch, j = heap.top().j;
        heap.pop();
        if (val == f[ch][j]) {
        //    cout << val << ' ' << ch << ' ' << j << endl;
            if (j == m) {
                cout << val;
                return;
            }
            REP(i, sz(l[ch])) {
                int jj = count(j, l[ch][i], 1);
                int c2 = l[ch][i].back();
                int len = sz(l[ch][i]) - 1;
                if (f[c2][jj] > f[ch][j] + len) {
                    f[c2][jj] = f[ch][j] + len;
                    heap.push(node(f[c2][jj], c2, jj));
                }
            }
        }
    }
    cout << -1 << endl;
}

int main() {
    //freopen("input.txt", "r", stdin);
    scanf("%s\n", s+1);
    m = strlen(s+1);
    For(i, 1, m) a[i] = s[i] - 'a';
    scanf("%d\n", &n);
    reset(f, 0x7f);
    For(i, 1, n) {
        scanf("%s\n", s+1);
        len = strlen(s+1);
        b.clear();
        For(i, 1, len) b.push_back(s[i] - 'a');
        l[b[0]].push_back(b);
        int j = count(0, b, 0);
//        cout << j << endl;
        if (f[b.back()][j] > len) {
            f[b.back()][j] = len;
            heap.push(node(len, b.back(), j));
        }
    }
    solve();
    //cout << f[0][5];
}
