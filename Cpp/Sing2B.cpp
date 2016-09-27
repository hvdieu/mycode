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

int ntest, n, dem1, dem2;
ll a1[20], a2[20];
vector<int> res;
ll kl[20], dem[20];

void phantich(int n) {
    res.clear();
    while (n) {
        int t = n % 3;
        res.pb(t);
        n /= 3;
    }
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> ntest;
    kl[0] = 1;
    For(i, 1, 19) kl[i] = kl[i-1]*3;
    For(test, 1, ntest) {
        cin >> n;
        phantich(n);
        dem1 = dem2 = 0;
        reset(dem, 0);
        REP(i, sz(res)) {
            if (res[i] == 1) dem[i]++;
            else if (res[i] == 2) dem[i] = 2;
        }
        For(i, 0, 19) {
            if (dem[i] == 2) {
                dem[i]--; dem[i+1]++; a1[++dem1] = kl[i];
            } else if (dem[i] == 1) {
                a2[++dem2] = kl[i];
            } else if (dem[i] == 3) {
                dem[i]--; dem[i+1]++;
            }
        }
        cout << "left pan: ";
        Rep(i, dem1, 1) cout << a1[i] << ' '; cout << endl;
        cout << "right pan: ";
        Rep(i, dem2, 1) cout << a2[i] << ' ';
        if (test < ntest) cout << endl << endl;
    }
}


