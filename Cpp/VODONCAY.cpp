#include <bits/stdc++.h>

using namespace std;

const int N = 4000000 + 10;

int n, h[N], f[N], t[N], t1[N][2], t2[N][2], g[N][2];
int st[N], top;
vector<int> l[N], r[N];

int initLeft() {
    top = 0;
    for(int i = 1; i <= n; i++) {
        int MIN = max(1, i-h[i]+1);
        while (top && st[top] > i-h[i]) MIN = min(MIN, f[st[top--]]);
        f[i] = MIN; st[++top] = i;
        l[MIN].push_back(i);
        //cout << MIN << ' ';
    }
    //cout << "\n";
}

int initRight() {
    top = 0;
    for(int i = n; i >= 1; i--) {
        int MAX = min(n, i+h[i]-1);
        while (top && st[top] < i+h[i]) MAX = max(MAX, f[st[top--]]);
        f[i] = MAX; st[++top] = i;
        r[i].push_back(MAX);
        //cout << MAX << ' ';
    }
    //cout << "\n";
}

void update(int i, int val) {
    for(i; i <= n+1; i += i & (-i)) t[i] = min(t[i], val);
}

int get(int i) {
    int res = n+1;
    for(i; i; i -= i & (-i)) res = min(res, t[i]);
    return res;
}

void KhuyenIsTheBest() {
    memset(t, 0x7f, sizeof t);
    update(n+1, 0);
    int res;
    memset(g, 0x7f, sizeof g);
    g[n+1][0] = g[n+1][1] = 0;
    for(int i = n; i >= 1; i--) {
        g[i][0] = g[i][1] = n+1;
        for(int jj = 0; jj < r[i].size(); jj++) {
            int j = r[i][jj];
            //g[i][0] = min(g[i][0], g[j+1][0] + 1);
            if (g[i][0] > g[j+1][0] + 1) {
                g[i][0] = g[j+1][0] + 1;
                t1[i][0] = j+1;
                t2[i][0] = 0;
            }
            //g[i][0] = min(g[i][0], get(j+1) + 1);
            int tmp = get(j+1) + 1;
            if (g[i][0] > tmp) {
                g[i][0] = tmp;
                t1[i][0] = j+1;
                t2[i][0] = 1;
            }
        }
        for(int jj = 0; jj < l[i].size(); jj++) {
            int j = l[i][jj];
            //g[i][1] = min(g[i][1], g[j+1][1] + 1);
            if (g[i][1] > g[j+1][1] + 1) {
                g[i][1] = g[j+1][1] + 1;
                t1[i][1] = j+1;
                t2[i][1] = 1;
            }
            //g[i][1] = min(g[i][1], g[j+1][0] + 1);
            if (g[i][1] > g[j+1][0] + 1) {
                g[i][1] = g[j+1][0] + 1;
                t1[i][1] = j+1;
                t2[i][1] = 0;
            }
        }
        update(i, g[i][1]);
    }
}

void trace(int i, int tt) {
    if (i > n) return;
    if (tt) {
        printf("%d ", -(t1[i][tt]-1));
        trace(t1[i][tt], t2[i][tt]);
    } else {
        printf("%d ", i);
        if (t2[i][tt] == 0) trace(t1[i][tt], t2[i][tt]);
        else {
            for(int j = i+1; j <= t1[i][tt]; j++)
            if (g[i][tt] == g[j][1] + 1) {
                trace(j, 1);
                return;
            }
        }
    }
}

void NothingCanBeatKhuyen() {
    if (g[1][0] < g[1][1]) {
        printf("%d\n", g[1][0]);
        trace(1, 0);
    } else {
        printf("%d\n", g[1][1]);
        trace(1, 1);
    }
}

int main() {
    freopen("DONCAY.INP", "r", stdin);
    freopen("DONCAY.OUT", "w", stdout);
    scanf("%d\n", &n);
    for(int i = 1; i <= n; i++) scanf("%d", h+i);
    initLeft();
    initRight();
    KhuyenIsTheBest();
    NothingCanBeatKhuyen();
}
