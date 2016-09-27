#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;
typedef vector<int> VI;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define N 110

map<VI, int> ff;
int n, k, test, ntest;
VI tt, start, finish;
vector< VI > l;
ll t;

void next() {
    if (tt == finish) { tt = start; return; }
    int i = 0;
    while (!tt[i]) i++;
    int j = i+1;
    while (tt[j]) j++;
    swap(tt[j], tt[j-1]);
    if (j - 2 >= 0) {
    	i = 0; j = j - 2;
    	while (i <= j) {
    		swap(tt[i], tt[j]);
    		i++; j--;
		}
	}
}

void solve() {
    start.clear(); finish.clear(); tt.clear();
    l.clear();
    For(i, 1, k) {
        start.pb(1); tt.pb(1);
    }
    For(i, 1, n-k) {
        start.pb(0); tt.pb(0);
    }
    For(i, 1, n-k) finish.pb(0); For(i, 1, k) finish.pb(1);
    ff.erase(all(ff));
    ff[start] = 1; l.pb(tt); l.pb(tt);
    int time = 1, lef, righ;
    while (1) {
        if (time == t) {
            For(i, 0, n-1) if (tt[i]) printf("B"); else printf("T"); printf("\n"); return;
        }
        time++;
        next();
        //For(i, 0, n-1) printf("%d", tt[i]); printf("\n");
        if (!ff[tt]) {
        	ff[tt] = time; l.pb(tt);
		}
        else {
            lef = ff[tt]; righ = time-1;
            break;
        }
    }
    int len = righ - lef + 1;
    t -= righ;
    t -= (t / len) * len; if (!t) t += len;
    For(i, 0, n-1) if (l[t][i]) printf("B"); else printf("T"); printf("\n");
}

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("light.inp","r",stdin);
    //freopen("light.out","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> n >> k >> t;
        solve();
    }
}
