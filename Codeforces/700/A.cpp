#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))

const double eps = 1e-12;

double v1, v2, l;
double ans;
int n, k;

bool check(double t) {
    double now = 0;
    int left = n;
    double pos = 0;
    double need = (l - v1*t) / (v2 - v1);
    double bus;
    now += need;
   // cout << now << ' ' << pos << "\n";
    if (now > t) return false;
    pos += need * v1;
    bus = need*v2;
    left -= min(left, k);
    while (left) {
        double tpick = (bus - pos) / (v1 + v2);
        now += tpick;
        bus -= tpick*v2;
        if (now > t) return false;
        pos += tpick * v1;
        need = (l - pos - v1*(t-now)) / (v2 - v1);
        if (need < 0) return false;
        now += need;
        if (now > t) return false;
        left -= min(left, k);
        pos += need * v1;
        bus += need*v2;
        //cout << now << ' ' << pos << "\n";
        if (pos >= l) n = 0;
    }
    return true;
}

int main() {
   // freopen("in.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n >> l >> v1 >> v2 >> k;
   // cout << check(2.5) << "\n";
    double lef = 0, righ = l / v1, mid, ans = l / v1;
    //cout << check(4.8);
    int cnt = 0;
    while (abs(righ-lef) > 1e-6) {
        mid = (righ + lef) /  2;
        if (check(mid)) {
            ans = mid;
            righ = mid;
        } else lef = mid;
    }
    printf("%.8f", ans);
}


