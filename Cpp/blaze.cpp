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
#define N 100010
#define K 31

struct node {
    int val, pos, len;
};

int n, k, res, m, t[N], f[N*K];
char s[N];
node b[N*K];

bool cmp(node a, node b) {
    return a.val < b.val;
}

void update(int i, int val) {
    while (i <= n) {
        t[i] = max(t[i], val);
        i += i & (-i);
    }
}

int get(int i) {
    int s = 0;
    while (i) {
        s = max(s, t[i]);
        i -= i & (-i);
    }
    return s;
}

void solve() {
    For(i, 1, n) {
        int tt = 0;
        int power = 1;
        For(j, 0, min(i, k) - 1) {
            tt += power * (int(s[i - j]) - int('0'));
            power *= 2;
            res = max(res, tt);
            ++m;
            b[m].val = tt; b[m].pos = i; b[m].len = j + 1;
        }
    }
    cout << res << endl;
    res = 0;
    sort(b + 1, b + m + 1, cmp);
   // For(i, 1, m) printf("%d %d %d\n", b[i].val, b[i].pos, b[i].len);
    int i = 1;
    while (i <= m) {
        int j = i;
        while (j < m && b[i].val == b[j+1].val) j++;
        For(k, i, j) {
            f[k] = get(b[k].pos - b[k].len) + 1;
            res = max(res, f[k]);
        }
        For(k, i ,j) update(b[k].pos, f[k]);
        i = j + 1;
    }
    cout << res;
}

int main() {
    freopen("blaze.inp","r",stdin);
    freopen("blaze.out","w",stdout);
    scanf("%d\n", &k);
    scanf("%s", (s+1));
    n = strlen(s+1);
    solve();
}


