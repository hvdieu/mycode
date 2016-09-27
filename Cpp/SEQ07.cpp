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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 1010

struct node {
    int i, j;
    string val;
    node (int b, int c, string d) {
        i = b; j = c; val = d;
    }
};

int n, m, t[N], f[N*N], res;
char s[N];
vector<node> a;
ull h[N], mu[N];


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

ull gethash(int i, int j) {
    return h[j] - h[i-1] * mu[j-i+1];
}

bool com(node a, node b) {
    if (sz(a.val) != sz(b.val)) return false;
    return a.val == b.val;
}

bool cmp(node a, node b) {
    if (sz(a.val) != sz(b.val)) return sz(a.val) < sz(b.val);
    return a.val < b.val;
}

void solve() {
	mu[0] = 1;
    For(i, 1, n) {
        h[i] = h[i-1] * 10 + int(s[i]) - int('0');
        mu[i] = mu[i-1] * 10;
    }
    For(i, 1, n) {
        string x; x.clear();
        bool flag = true;
        int len = 0;
        For(j, i, min(n, i + 50)) {
            if (s[j] == '0') {
                if (!flag) x += s[j];
            } else x += s[j];
            if (s[j] != '0') flag = false;
            a.pb(node(i, j, x));
            m++;
        }
    }
    sort(a.begin(),a.end(), cmp);
    int i = 0; m--;
    while (i <= m) {
        int j = i;
        while (j < m && com(a[j+1], a[i])) j++;
        For(k, i, j) {
            f[k] = get(a[k].i-1) + 1;
            res = max(res, f[k]);
        }
        For(k, i, j) update(a[k].j, f[k]);
        i = j + 1;
    }
    //cout << com(a[0], a[3]);
   cout << res;
  // For(i, 0, m-1) cout << a[i].val << ' ' << a[i].i << ' ' << a[i].j << ' ' << f[i] << endl;
}

int main() {
    freopen("seq07.inp","r",stdin);
    freopen("seq07.out","w",stdout);
    scanf("%d", &n);
    scanf("%s\n", s+1);
    solve();
}
