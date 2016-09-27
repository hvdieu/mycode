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
#define BASE 1000000009
#define N 110

int n, m, k;
char s1[N], s2[N];
int f[N][N], c[N][N];

void add(int &a, int b) {
    a += b; if (a >= BASE) a -= BASE;
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    For(nn, 0, 100) c[0][nn] = 1;
    For(kk, 1, 100) For(nn, k, 100) c[kk][nn] = (c[kk-1][nn-1] + c[kk][nn-1]) % BASE;
    while (cin >> n >> k >> m) {
        cin >> s1+1; cin >> s2+1;
        int dem = 0;
        For(i, 1, n) if (s1[i] != s2[i]) dem++;
        reset(f, 0);
        f[0][dem] = 1;
        For(i, 0, k-1) For(khac, 0, n) {
            int giong = n - khac;
            For(ckhac, 0, khac) {
                int cgiong = m - ckhac;
                if (cgiong >= 0 && ckhac >= 0 && ckhac <= khac && cgiong <= giong) {
                    int sc = (ll(c[ckhac][khac])*c[cgiong][giong]) % BASE;
                    add(f[i+1][khac - ckhac + cgiong], (ll(f[i][khac])*sc) % BASE);
                }
            }
        }
        cout << f[k][0] << endl;
    }
}
