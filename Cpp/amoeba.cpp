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
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 51

int n, k, ans;
char s[N];
int a[N], d[8];
bool flag;

void duyet(int i, int len) {
    if (i > n) {
        flag = true; return;
    }
    if (flag) return;
    For(j, 1, k) if (!a[i] || (a[i] == j)) {
        int luu = d[j];
        if (d[j] < 0 || (i-d[j] >= len)) {
            d[j] = i;
            duyet(i+1, len);
            d[j] = luu;
        }
    }
}

int main() {
    ios_base::sync_with_stdio(false);
    freopen("amoeba.inp","r",stdin);
    freopen("amoeba.out","w",stdout);
    cin >> s+1;
    cin >> k;
    n = strlen(s+1);
    For(i, 1, n) a[i] = int(s[i]) - int('0');
    Rep(len, k, 1) {
        flag = false; reset(d, -1);
        duyet(1, len);
        if (flag) { ans = len; break; }
    }
    cout << ans;
}
