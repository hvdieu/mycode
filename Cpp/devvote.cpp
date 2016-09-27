#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 36

int n, ntest, lim;
int base;
vector<int> a;
map< vector<int>, double> f[37][18];
map< vector<int>, double>::iterator it;

const double kq[36] = {1.000000, 2.000000, 2.000000, 1.777778, 1.656250, 1.660800, 1.733668, 1.828592, 1.920742, 1.999589, 2.062219, 2.109256, 2.142717, 2.164972, 2.178301, 2.184725, 2.185964, 2.183446, 2.178343, 2.171597, 2.163963, 2.156033, 2.148263, 2.141000, 2.134497, 2.128932, 2.124422, 2.121035, 2.118798, 2.117709, 2.117741, 2.118848 , 2.120971 , 2.124043, 2.127988, 2.132728};

double cal(int i, int last, int MAX) {
	if (i > n) {
        double res = a[MAX];
        res /= n; For(j, 2, n) res /= n-1;
        return res;
	}
    it = f[i][last].find(a);
    if (it != f[i][last].end()) return it->se;
    double res = 0;
    For(j, 0, lim) if (a[j] > 0)
    if (i == 1 || (i > 1 && (j != last || (j == last && a[last] > 1)))) {
        int sc;
        if (i == 1 || j != last) sc = a[j]; else sc = a[j] - 1;
        a[j]--; a[j+1]++;
        res += cal(i+1, j+1, max(MAX, j+1))*sc;
        a[j]++; a[j+1]--;
    }
    f[i][last][a] = res;
    return res;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    cin >> ntest;
    For(test, 1, ntest) {
        cin >> n;
        //a.clear(); lim = (n+1)/2; For(i, 0, lim) a.pb(0); a[0] = n;
       // For(i, 1, n) For(j, 0, lim) f[i][j].erase(all(f[i][j]));
       // double res = cal(1, 0, 0);
        printf("%.6lf\n", kq[n-1]);
    }
}
