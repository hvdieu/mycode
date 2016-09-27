#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bug(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 22
#define TT 2097153

int ntest, n, k, dem;
ll a[N], sum;
int fr[TT];
queue<int> q;

void solve() {
    sum /= k; dem++;
    q.push(0); fr[0] = dem;
    while (!q.empty()) {
        ll s = 0;
        int tt = q.front(); q.pop();
        For(i, 0, n-1) if (bug(tt, i)) s += a[i];
        s %= sum;
        For(i, 0, n-1) if (!bug(tt, i) && s + a[i] <= sum) {
            int stt = onbit(tt, i);
            if (fr[stt] != dem) {
                fr[stt] = dem;
                q.push(stt);
            }
        }
    }
    if (fr[two(n)-1] != dem) printf("no\n");
    else printf("yes\n");
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d", &n, &k);
        sum = 0;
        For(i, 0, n-1) {
            scanf("%lld", &a[i]);
            sum += a[i];
        }
        if (sum % k || k > n) printf("no\n");
        else if (!sum) printf("yes\n");
        else solve();
    }
}




