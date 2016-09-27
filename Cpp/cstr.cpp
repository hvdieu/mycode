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
#define N 101

struct node {
    int x, y, z;
    node(int _x, int _y, int _z) {
        x = _x; y = _y; z = _z;
    }
};

char s[3][N];
int n, f[N][2*N][2*N];
char trace[N][2*N][2*N];
vector<string> kq;

int id(int i) {
    return i + n;
}

string truyvet(int i, int j, int k) {
    string res; res.clear();
    if (!i) return res;
    char ch = trace[i][j][k];
    int x = f[i][j][k], y = x + j - n, z = x + k - n;
    if (ch != s[0][i]) x--;
    if (ch != s[1][i]) y--;
    if (ch != s[2][i]) z--;
    return truyvet(i-1, y-x+n, z-x+n) + ch;
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    For(i, 0, 2) scanf("%s\n", s[i]+1);
    n = strlen(s[0]+1);
    For(i, 0, 2) For(j, 1, n / 2)
	swap(s[i][j], s[i][n-j+1]);
    For(i, 0, n) For(j, 0, 2*n) For(k, 0, 2*n)
    f[i][j][k] = n+1;
    f[0][n][n] = 0;
    For(i, 0, n-1) For(j, 0, 2*n) For(k, 0, 2*n) if (f[i][j][k] <= n) {
        int x = f[i][j][k], y = x + j - n, z = x + k - n;
        For(j, 0, 2) {
            char ch = s[j][i+1];
            int xx = x, yy = y, zz = z;
            if (ch != s[0][i+1]) xx++;
            if (ch != s[1][i+1]) yy++;
            if (ch != s[2][i+1]) zz++;
            if (f[i+1][yy-xx+n][zz-xx+n] > xx) {
                f[i+1][yy-xx+n][zz-xx+n] = xx;
                trace[i+1][yy-xx+n][zz-xx+n] = ch;
            } else if (f[i+1][yy-xx+n][zz-xx+n] == xx && trace[i+1][yy-xx+n][zz-xx+n] > ch)
            trace[i+1][yy-xx+n][zz-xx+n] = ch;
        }
            char ch = 'A';
            int xx = x, yy = y, zz = z;
            if (ch != s[0][i+1]) xx++;
            if (ch != s[1][i+1]) yy++;
            if (ch != s[2][i+1]) zz++;
            if (f[i+1][yy-xx+n][zz-xx+n] > xx) {
                f[i+1][yy-xx+n][zz-xx+n] = xx;
                trace[i+1][yy-xx+n][zz-xx+n] = ch;
            } else if (f[i+1][yy-xx+n][zz-xx+n] == xx && trace[i+1][yy-xx+n][zz-xx+n] > ch)
            trace[i+1][yy-xx+n][zz-xx+n] = ch;
    }
    int res = n+1;
    For(j, 0, 2*n) For(k, 0, 2*n) if (f[n][j][k] <= n) {
        int x = f[n][j][k], y = x + j - n, z = x + k - n;
        int X = max(max(x, y), z);
        if (res >= X) {
            if (res > X) kq.clear();
            res = X;
            kq.pb(truyvet(n, j, k));
        }
    }
  //  truyvet(4, 4, 4);
   // cout << trace[3][4][3];
    For(j, 0, sz(kq)-1) reverse(all(kq[j]));
    sort(all(kq));
    cout << kq[0];
}
