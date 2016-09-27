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
#define N 1000000

int n;
int fr[N];

bool check(int x) {
    bool dd[10]; reset(dd, 0);
    while (x) {
        dd[x % 10]++; x /= 10;
    }
    int res = 0;
    For(i, 0, 9) if (dd[i]) res++;
    return res == 1;
}

int tinh(int ch) {
    int i = 0;
    reset(fr, 0);
    int du = 0;
    while (1) {
        i++; du = (du * 10 + ch) % n;
        if (!du) return i;
        if (fr[du]) return -1;
        fr[du] = 1;
    }
}

void inkq(int ch, int len) {
    vector<int> c; c.clear();
    int nho = 0, s = 0;
    For(i, 1, len) {
        nho = nho*10 + ch;
        s = nho / n;
        nho = nho % n;
        c.pb(s);
    }
    reverse(all(c));
    while (!c[sz(c)-1]) c.pop_back();
    reverse(all(c));
    For(i, 0, sz(c)-1) printf("%d", c[i]);
}

int main() {
   // ios_base::sync_with_stdio(false);
    freopen("number.inp","r",stdin);
    freopen("number.out","w",stdout);
    while (cin >> n) {
        if (check(n)) cout << 1;
        else {
            int len = 1000000000; int res = -1;
            For(ch, 1, 9) {
                int x = tinh(ch);
                if (x < len && x > 0) { len = x; res = ch; }
            }
            if (res == -1) cout << -1;
            else inkq(res, len);
        }
        cout << endl;
    }
}
