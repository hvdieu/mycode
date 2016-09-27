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
#define N 51
#define NUM 100

int n, a[N][N], res;
int stt[2*N];

void change(int i, int t) {
    if (!t) For(j, 1, n) a[i][j] = 1-a[i][j];
    else For(j, 1, n) a[j][i] = 1-a[j][i];
}

int Count() {
    int res = 0;
    For(i, 1, n) For(j, 1, n) res += a[i][j];
    return res;
}

void local() {
    For(test, 1, 1000) {
        For(i, 1, 2*n) {
            int j = rand() % (2*n) + 1;
            if (i <= n) change(i, 0); else change(i-n, 1);
            if (j <= n) change(j, 0); else change(j-n, 1);
            int dem = Count();
            if (dem < res) {
                res = dem;
                stt[i] = 1-stt[i]; stt[j] = 1-stt[j];
            } else {
                if (i <= n) change(i, 0); else change(i-n, 1);
                if (j <= n) change(j, 0); else change(j-n, 1);
            }
        }
    }
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) For(j, 1, n) {
        scanf("%d", &a[i][j]);
        res += a[i][j];
    }
    bool stop = false;
    while (!stop) {
        stop = true;
        For(i, 1, n) {
            int dem = 0;
            For(j, 1, n) dem += a[i][j];
            if (dem > n - dem) {
                stt[i] = 1 - stt[i];
                For(j, 1, n) a[i][j] = 1 - a[i][j];
                res = res - dem + n - dem;
                stop = false;
            }
        }
        For(j, 1, n) {
            int dem = 0;
            For(i, 1, n) dem += a[i][j];
            if (dem > n-dem) {
                stt[j+n] = 1-stt[j+n];
                For(i, 1, n) a[i][j] = 1-a[i][j];
                res = res - dem + n - dem;
                stop = false;
            }
        }
    }
    local();
    cout << res << endl;
    For(i, 1, 2*n) cout << stt[i] << endl;
}
