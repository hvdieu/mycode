#include <bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef pair<int, int> ii;
typedef long double ld;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i--)
#define fi first
#define se second
#define pb push_back
#define all(x) x.begin(), x.end()
#define sz(x) (int(x.size()))
#define reset(f, x) memset(f, x, sizeof(f))
#define bit(x, i) ((x >> i) & 1)
#define two(x) (1LL << x)
#define onbit(x, i) (x | (1LL << i))
#define N 50010
#define inf 1000000000000000000LL

int n;
ll k;
vector<ll> a;
set<ll> ff;
bool stop;

ll gcd(ll a, ll b) {
    if (!b) return a;
    return gcd(b, a % b);
}

ll lcm(ll a, ll b) {
    ll x = a / gcd(a, b);
    if ((inf / x) < b) return -1;
    return b * (a / gcd(a, b));
}

void push(ll x) {
    if (x < 0) return;
    if (ff.find(x) == ff.end()) {
        ff.insert(x);
        n++;
        a.pb(x);
        stop = false;
    }
}

void sub1() {
    ff.erase(all(ff));
    For(i, 1, n) ff.insert(a[i]);
    bool flag = false;
    stop = false;
    while (!stop) {
        if (ff.find(k) != ff.end()) {
            flag = true;
            break;
        }
        stop = true;
        For(i, 1, n) For(j, i+1, n) {
            ll x = gcd(a[i], a[j]);
            push(x);
            x = lcm(a[i], a[j]);
            push(x);
        }
    }
    if (flag) cout << "YES"; else cout << "NO";
    cout << endl;
  //  For(i, 1, n) cout << a[i] << ' '; cout << endl;
}

bool check(ll x, ll j) {
    For(i, 1, n) if (a[i] % x == 0) {
        ll y = a[i] / x;
        if (y % j) return true;
    }
    return false;
}

void sub2() {
    ll mgcd = a[1];
    For(i, 2, n) mgcd = gcd(a[i], mgcd);
    bool flag = true;
    if (k % mgcd) flag = false;
    int ss = trunc(sqrt(k));
    For(j, 2, ss) if (k % j == 0) {
        ll x = 1;
        while (k % j == 0) {
            x *= j; k /= j;
        }
        flag &= check(x, j);
    }
    if (k > 1) flag &= check(k, k);
    if (flag) cout << "YES"; else cout << "NO";
    cout << endl;
}

int main() {
    freopen("CRYPTKEY.INP", "r", stdin);
    freopen("CRYPTKEY.OUT", "w", stdout);
    int ntest;
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        a.clear(); ll x;
        a.pb(0);
        For(i, 1, n) {
            scanf("%lld", &x);
            a.pb(x);
        }
        scanf("%lld", &k);
        if (n <= 10) sub1();
        else
        sub2();
    }
}
