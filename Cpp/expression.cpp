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
#define N 100001
#define inf 1000000000

int n, st[N], top, tt[N], b[N], m;
char s[N];
set<int> ff;
set<int>::iterator it;

void solve() {
    int num = 0, dau = 1;
    bool flag = false;
    For(i, 1, n) {
        if (s[i] == '-') dau = -1;
        else if (s[i] >= '0' && s[i] <= '9') {
            int ch = s[i] - '0';
            num = num * 10 + ch;
            flag = true;
        } else {
            if (flag) {
                st[++top] = num * dau;
                num = 0; dau = 1;
                flag = false;
            }
            if (s[i] == '(') st[++top] = inf + 1;
            else if (s[i] == '[') st[++top] = inf + 2;
            else if (s[i] == ')') {
                int now = top, sum = 0, res = -inf, mi = 0;
                while (st[top] != inf + 1) {
                    sum += st[top];
                    res = max(res, sum - mi);
                    mi = min(mi, sum);
                    top--;
                }
                st[top] = res;
            } else if (s[i] == ']') {
                int len = 0; ff.erase(ff.begin(), ff.end());
                while (st[top] != inf + 2) {
                    b[++len] = st[top]; top--;
                }
                sort(b + 1, b + len + 1);
                st[top] = b[(len+1) / 2];
            }
        }
    }
    if (flag) st[++top] = num * dau;
    int res = 0;
    For(i, 1, top) res += st[i];
    cout << res;
}

int main() {
    freopen("expression.inp","r",stdin);
    freopen("expression.out","w",stdout);
    scanf("%s", (s+1));
    n = strlen(s+1);
    solve();
}
