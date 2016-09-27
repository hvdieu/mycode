#include <bits/stdc++.h>

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
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()
#define N 510

const int h[4] = {-1, 0, 1, 0};
const int c[4] = {0, 1, 0, -1};

struct node {
    int val, i, j;
};

int m, n, d, a[N][N], cnt, root[N*N], maxr[N*N], pos[N][N], res, dd[N][N];
node Q[N*N];

bool cmp(node a, node b) {
    return a.val < b.val;
}

int getroot(int u) {
    if (root[u] != u) root[u] = getroot(root[u]);
    return root[u];
}

void connect(int i, int j) {
    dd[i][j] = 1;
    For(k, 0, 3) {
        int u = i + h[k], v = j + c[k];
        if (u && v && u <= m && v <= n && dd[u][v]) {
            int r1 = getroot((i-1)*n + j);
            int r2 = getroot((u-1)*n + v);
            if (r1 != r2) {
                root[r1] = root[r2];
                maxr[root[r2]] = max(maxr[root[r2]],maxr[r1]);
            }
        }
    }
}

void solve() {
    sort(Q+1, Q+m*n+1, cmp);
    For(i, 1, m*n) pos[Q[i].i][Q[i].j] = i;
    For(i, 1, m) For(j, 1, n) {
        root[(i-1)*n+j] = (i-1)*n + j;
        maxr[(i-1)*n+j] = pos[i][j];
    }
    int i = m*n, k = m*n;
    while (i > 0) {
        int j = i;
        while (j > 1 && Q[i].val == Q[j-1].val) j--;
        while (k && Q[k].val > Q[i].val - d) {
            connect(Q[k].i, Q[k].j); k--;
        }
        For(jj, j, i) {
            int r1 = getroot((Q[jj].i-1)*n + Q[jj].j);
            if (maxr[r1] <= i) res++;
        }
        i = j - 1;
    }
    cout << res;
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d %d %d", &m, &n, &d);
    For(i, 1, m) For(j, 1, n) {
        scanf("%d", &a[i][j]);
        cnt++; Q[cnt].val = a[i][j]; Q[cnt].i = i; Q[cnt].j = j;
    }
    solve();
}


