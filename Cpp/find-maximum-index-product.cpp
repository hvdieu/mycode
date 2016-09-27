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
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 100010

int n, a[N], l[N], st[N], top;
ll res;

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n); For(i, 1, n) scanf("%d", a+i);
    top = 0; st[0] = 0;
    For(i, 1, n) {
        while (top && a[i] >= a[st[top]]) top--;
        l[i] = st[top]; st[++top] = i;
    }
    top = 0; st[0] = 0;
    Rep(i, n, 1) {
        while (top && a[i] >= a[st[top]]) top--;
        res = max(res, ll(st[top]) * l[i]);
        st[++top] = i;
    }
    cout << res;
}
