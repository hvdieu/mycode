#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef pair<unsigned long long, int> ulli;
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
#define N 50010

int n, len[5], bound, dd[5];
char s[5][N];
ull h[5][N], mu[N];
vector<ulli> q;

ull gethash(int t, int i, int j) {
    return h[t][j] - h[t][i-1] * mu[j - i + 1];
}

void solve() {
    Rep(l, bound, 1) {
        q.clear();
        For(i, 1, n) For(j, 1, len[i] - l + 1)
        q.push_back(ulli(gethash(i,j,j + l - 1),i));
        sort(q.begin(), q.end());
        int i = 0;
        while (i < sz(q)) {
            reset(dd, false);
            dd[q[i].se] = true;
            int j = i;
            while (j < sz(q) - 1 && q[i].fi == q[j+1].fi) {
                j++; dd[q[j].se] = true;
            }
            bool flag = true;
            For(t, 1, n) flag &= dd[t];
            if (flag) {
                cout << l; return;
            }
            i = j + 1;
        }
    }
}

int main() {
    freopen("substr14.inp","r",stdin);
    freopen("substr14.out","w",stdout);
    scanf("%d\n",&n);
    mu[0] = 1;
    bound = 60;
    For(i, 1, 50000) mu[i] = mu[i-1] * 2;
    For(i,1,n) {
        scanf("%s\n",(s[i] + 1));
        len[i] = strlen(s[i]+1);
        bound = min(bound, len[i]);
        For(j, 1, len[i]) h[i][j] = h[i][j-1] * 2 + int(s[i][j]) - int('a');
    }
    solve();
}
