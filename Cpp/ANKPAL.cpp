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
#define p 47
#define p2 57
#define BASE 1000000007
#define N 100010

int n;
char s[N];
string ss;
long long h[2][N], mu[N];

void init() {
    mu[0] = 1;
    for(int i = 1; i <= n; i++) mu[i] = (mu[i-1]*p) % BASE;
    for(int i = 1; i <= n; i++) h[0][i] = (h[0][i-1]*p + s[i] - 'a' + 1) % BASE;
    for(int i = n; i >= 1; i--) h[1][i] = (h[1][i+1]*p + s[i] - 'a' + 1) % BASE;
}

int get(int t, int i, int j) {
    if (!t) return (h[t][j] - ((h[t][i-1]*mu[j-i+1]) % BASE) + BASE) % BASE;
    return (h[t][i] - ((h[t][j+1]*mu[j-i+1]) % BASE) + BASE) % BASE;
}

bool check(int i, int j) {
    while (i <= j) {
        if (ss[i] != ss[j]) return false;
        i++; j--;
    }
    return true;
}

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%s\n", s+1);
    n = strlen(s+1);
    For(i, 1, n) ss.pb(s[i]);
    init();
    int Q; scanf("%d", &Q);
    while (Q) {
        Q--;
        int i, j, u, v;
        scanf("%d%d%d%d", &i, &j, &u, &v);
        int l = max(u, i), r = min(v, j);
        long long hash1 = 0, hash2 = 0;
        bool flag;
       // i--;
       // reverse(ss.begin()+i, ss.begin()+j);
        //cout << ss << endl;
      //  if (check(u-1, v-1)) flag = true; else flag = false;
      //  reverse(ss.begin()+i, ss.begin()+j);
     //   i++;
        if (l > r) {
            hash1 = get(0, u, v); hash2 = get(1, u, v);
        } else {
            if (u <= i && j <= v) {
                if (u <= i-1) hash1 = (hash1 * mu[i-u] + get(0, u, i-1)) % BASE;
                hash1 = (hash1 * mu[j-i+1] + get(1, i, j)) % BASE;
                if (j+1 <= v) hash1 = (hash1 * mu[v-j] + get(0, j+1, v)) % BASE;

                if (j+1 <= v) hash2 = (hash2 * mu[v-j] + get(1, j+1, v)) % BASE;
                hash2 = (hash2 * mu[j-i+1] + get(0, i, j)) % BASE;
                if (u <= i-1) hash2 = (hash2 * mu[i-u] + get(1, u, i-1)) % BASE;
            } else if (i <= u && v <= j) {
                int len = v-u+1;
                int kc = u-i+1;
                v = j - kc + 1;
                u = v - len + 1;
                hash1 = get(0, u, v); hash2 = get(1, u, v);
            } else {
                int len = r-l+1;
                if (v < j) {
                    if (u <= i-1) hash1 = (hash1 * mu[i-u] + get(0, u, i-1)) % BASE;
                    hash1 = (hash1 * mu[len] + get(1, j-len+1, j)) % BASE;

                    hash2 = (hash2 * mu[len] + get(0, j-len+1, j)) % BASE;
                    if (u <= i-1) hash2 = (hash2 * mu[i-u] + get(1, u, i-1)) % BASE;
                } else {
                    hash1 = (hash1 * mu[len] + get(1, i, i+len-1)) % BASE;
                    if (j+1 <= v) hash1 = (hash1 * mu[v-j] + get(0, j+1, v)) % BASE;

                    if (j+1 <= v) hash2 = (hash2 * mu[v-r] + get(1, j+1, v)) % BASE;
                    hash2 = (hash2 * mu[len] + get(0, i, i+len-1)) % BASE;
                }
            }
        }
        if (hash1 == hash2) printf("Yes\n"); else printf("No\n");
    }
}


