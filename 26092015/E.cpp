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
#define N 110

int n, m, ntest, k;
char s[N], a[N];
bool fr[26];
bool b[26];

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    For(test, 1, ntest) {
        scanf("%d %s %s\n", &k, s+1, a+1);
        //cout << s + 1 << ' ' << a+1 << endl;
        n = strlen(s+1); m = strlen(a+1);
        reset(b, true);
        int cnt = 0;
        For(i, 1, n) if (b[s[i]-'a']) {
            b[s[i] - 'a'] = false;
            cnt++;
        }
        reset(fr, true);
        int dem = 0;
        For(i, 1, m) if (!fr[a[i] - 'a']) dem++;
        else {
            fr[a[i] - 'a'] = false;
            bool ok = true;
            For(j, 1, n) if (s[j] == a[i]) ok = false;
            dem += ok;
            if (ok == false) {
                cnt--;
            }
            if (!cnt) break;
        }
       // cout << dem << endl;
        if (dem < k && !cnt) cout << "Correct" << endl; else cout << "Wrong" << endl;
    }
}


