#include <bits/stdc++.h>

using namespace std;
typedef pair<double, double> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> (i)) & 1LL)
#define onbit(x, i) (x | (1LL << (i)))
#define offbit(x, i) (x & ~(1 << (i)))

const int N = 100;
const int S = 201;
const double inf = 1e9;
const double lim = 12;

int n, s, m, p[N];
ii a[N+S];
ii b[S];
double t[S+N][S+N];
vector<int> line;
vector<int> res, now;
bool was[N];

double dist(ii A, ii B) {
    double xx = A.x - B.x, yy = A.y - B.y;
    return sqrt(xx*xx + yy*yy);
}

int main() {
    //ios_base::sync_with_stdio(0);
    //freopen("input.txt", "r", stdin);
    cin >> a[0].x >> a[0].y;
    cin >> n;
    For(i, 1, n) cin >> a[i].x >> a[i].y;
    cin >> s;
    For(i, n+1, n+s) cin >> a[i].x >> a[i].y;
    For(i, 0, n+s) For(j, 0, n+s)
    if (i == j) t[i][j] = 0;
    else t[i][j] = dist(a[i], a[j]) / 5;
    scanf("%d\n", &m);
    For(i, 1, m) {
        char ch; line.clear(); int x;
        string str;
        getline(cin, str);
        istringstream ss(str);
        int num;
        while (ss >> num)
		line.pb(num+n);
        FOR(u, line) FOR(v, line) t[*u][*v] = min(t[*u][*v], dist(a[*u], a[*v]) / 25);
    }
    For(k, 0, n+s) For(u, 0, n+s) For(v, 0, n+s)
        t[u][v] = min(t[u][v], t[u][k] + t[k][v]);

    For(i, 1, n) p[i] = i;
    int T = 1;
    For(i, 2, n) T = T * i;
    For(tt, 1, T) {
        double time = 0; now.clear();
        int u = 0;
        For(i, 1, n) {
            int v = p[i];
            if (time + 1 + t[u][v] <= lim) time += t[u][v] + 1, now.pb(v), u = v;
            else if (time + t[u][v] <= lim) {
                now.pb(v);
                break;
            }
        }
        if (now.size() > res.size() || (now.size() == res.size() && lexicographical_compare(all(now), all(res)))) {
            res.clear();
            FOR(i, now) res.pb(*i);
        }
        //cout << res.size() << ' ';
        next_permutation(p+1, p+n+1);
    }
    //cout << "\n";
    cout << res.size() << "\n";
    FOR(i, res) cout << *i << ' ';
}


