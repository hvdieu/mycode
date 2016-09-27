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
#define N 510

int n, m, k, a[N], dem, bang[N], res, kq[N];
vector<int> ke[N];


int main() {
    srand(time(NULL));
   // freopen("input.txt","r",stdin);
   // freopen("","w",stdout);
    scanf("%d%d%d", &n, &m, &k);
    res = n*n;
    For(i, 1, m) {
        int u, v;
        scanf("%d%d", &u, &v);
        ke[u].pb(v);
    }
    For(i, 1, n) a[i] = i;
    For(time, 1, 10000) {
        For(i, 1, n) {
            int j = rand() % n; j++;
            swap(a[i], a[j]);
        }
        dem = 0; int cnt = 1;
        For(i, 1, n) {
            dem++;
            if (dem > n/k) cnt++, dem = 1;
            bang[a[i]] = cnt;
        }
        int temp = 0;
        For(i, 1, n) FOR(j, ke[i]) if (bang[i] != bang[*j]) temp++;
        if (temp < res) {
            res = temp;
            For(i, 1, n) kq[i] = a[i];
        }
    }
    cout << res << endl;
    int dem = 0;
    For(i, 1, k) {
        For(j, 1, n/k) cout << kq[++dem] << ' ';
        cout << endl;
    }
}



