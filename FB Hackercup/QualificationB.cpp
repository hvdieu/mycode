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
#define N 21

int x[N], y[N], z[N], n;
string flag;
int ntest, X, Y, Z;

void ql(int i, int xx, int yy, int zz) {
    if (i > n) {
        if (xx == X && yy == Y && zz == Z) flag = "yes";
        return;
    }
    ql(i+1, xx, yy, zz);
    if (xx + x[i] <= X && yy + y[i] <= Y && zz + z[i] <= Z) ql(i+1, xx+x[i], yy+y[i], zz+z[i]);
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    cin >> ntest;
    int dem = 0;
    while (ntest) {
        ntest--; flag = "no";
        cin >> X >> Y >> Z;
        cin >> n;
        For(i, 1, n) cin >> x[i] >> y[i] >> z[i];
        ql(1, 0, 0, 0);
        printf("Case #%d: ", ++dem);
        cout << flag << endl;
    }
}
