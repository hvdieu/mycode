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
#define N 20010

int n, k;
string s, ss;
int z[N];

void z_algo() {
    int L = 0, R = 0;
    for (int i = 1; i < n; i++) {
        if (i > R) {
            L = R = i;
            while (R < n && s[R-L] == s[R]) R++;
            z[i] = R-L; R--;
        } else {
            int k = i-L;
            if (z[k] < R-i+1) z[i] = z[k];
            else {
                L = i;
                while (R < n && s[R-L] == s[R]) R++;
                z[i] = R-L; R--;
            }
        }
    }
}

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d\n", &k);
    cin >> s;
    n = sz(s);
    ss = s;
    reverse(all(ss));
    if (ss == s || k == n) {
        cout << 1 << endl;
        cout << s;
    } else {
        z_algo();
        For(len, 2, k) if (n % len == 0) {
            bool flag = true;
            for(int i = len; i < n; i += len)
            if (z[i] < len) {
                flag = false; break;
            }
            if (flag) {
                cout << 1 << endl;
                for(int i = 0; i < k; i++) cout << s[i];
                return 0;
            }
        }
        cout << 2 << endl;
        cout << s[0] << endl;
        for(int i = 0; i < n; i++) if (s[i] != s[0]) {
            cout << s[i] << endl;
            break;
        }
    }
}
