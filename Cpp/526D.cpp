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
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1000010

int n, k, z[N];
char s[N];
int kq[N];

void z_func() {
    z[1] = 0;
    int L = 0, R = 0;
    For(i, 2, n)
        if (i > R) {
            L = R = i;
            while (R <= n && s[R-L+1] == s[R]) R++;
            z[i] = R - L; R--;
        } else {
            int k = i-L+1;
            if (z[k] < R-i+1) z[i] = z[k];
            else {
                L = i;
                while (R <= n && s[R-L+1] == s[R]) R++;
                z[i] = R-L; R--;
            }
        }
}

int main() {
  //  freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d\n", &n, &k);
    scanf("%s\n", s+1);
    z_func();
 //   For(i, 1, n) cout << z[i] << ' '; cout << endl;
    For(len, 1, n / k) {
        bool flag = true;
        int i = 1;
        For(sl, 2, k) {
            i += len;
            if (z[i] < len) {
                flag = false;
                break;
            }
        }
        if (flag) {
            i += len;
            kq[i-1]++;
            kq[i]--;
            if (i <= n) {
                kq[i]++; kq[i + min(z[i], len)]--;
            }
        }
    }
   // cout << z[10] << endl;
   // For(i, 1, n) cout << kq[i] << ' '; cout << endl;
    For(i, 1, n) {
        kq[i] += kq[i-1];
        if (kq[i] > 0) printf("1"); else printf("0");
    }
}
