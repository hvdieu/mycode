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
#define N 100010

struct node {
    ll sumA, sumB, sumAB;
    int sum;
};

int n, m, A, B;
int a[N], b[N];
int t[N], l[N], r[N], val[N];
bool dd[N];


int main() {
  //  freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    reset(dd, true);
    For(i, 1, n) {
        scanf("%d%d", a+i, b+i);
    }
    For(i, 1, m) {
        scanf("%d%d%d", t+i, l+i, r+i);
        if (t[i] < 5) scanf("%d", val+i);
    }
    scanf("%d%d", &A, &B);
    //cout << A << " " << B << endl;
    For(i, 1, n) if (a[i] <= 0 || b[i] <= 0 || a[i] > A || b[i] > B) dd[i] = false;
    For(i, 1, m) {
        ll res = 0;
        For(j, l[i], r[i]) {
            if (t[i] == 1) a[j] = val[i];
            else if (t[i] == 2) b[j] = val[i];
            else if (t[i] == 3) a[j] += val[i];
            else if (t[i] == 4) b[j] += val[i];
            else if (t[i] == 5 && dd[j]) res += ll(a[j]) * b[j];
            else if (t[i] == 6 && dd[j]) res++;
            if (a[j] <= 0 || b[j] <= 0 || a[j] > A || b[j] > B) dd[j] = false;
        }
        if (t[i] >= 5) printf("%lld\n", res);
    }
}


