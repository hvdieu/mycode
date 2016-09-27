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

string l, r, res, l1, r1, l2, r2, base;

string add(string a, string b) {
    string c; c.clear();
    reverse(all(a)); reverse(all(b));
    int nho = 0;
    For(i, 0, max(sz(a), sz(b))-1) {
        int x = nho;
        if (i < sz(a)) x += a[i] - '0';
        if (i < sz(b)) x += b[i] - '0';
        nho = x / 10; x %= 10;
        c.pb(char(x + '0'));
    }
    if (nho) c.pb(1 + '0');
    reverse(all(c));
    return c;
}

string sub(string a, string b) {
    reverse(all(a)); reverse(all(b));
    string c; c.clear();
    int nho = 0;
    For(i, 0, sz(a)-1) {
        int x = a[i] - '0' - nho;
        if (i < sz(b)) x -= b[i] - '0';
        if (x < 0) {
            x += 10; nho = 1;
        } else nho = 0;
        //cout << "tru " << x << endl;
        c.pb(char(x + '0'));
    }
    //while (c[sz(c)-1] == '0') c.pop_back();
    reverse(all(c));
  //  cout << "tru " << c << endl;
    return c;
}

string mul(string a, int b) {
    string c; c.clear();
    int nho = 0;
    reverse(all(a));
    For(i, 0, sz(a)-1) {
        int x = (a[i] - '0') * b + nho;
        nho = x / 10; x %= 10;
        c.pb(char(x + '0'));
    }
    while (nho) {
        int x = nho % 10; nho /= 10;
        c.pb(char(x + '0'));
    }
    reverse(all(c));
    return c;
}

int main() {
   // freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    For(i, 1, 101) cout << 9; cout << endl;
    cin >> l >> r;
    cout << 1 << endl;
    cin >> l >> r;
    if (r == "0") {
        if (l == "0") cout << "Answer 1";
        else cout << "Answer 2";
        return 0;
    }
    res = "1"; base = "1";
    while (1) {
        base = mul(base, 2);
        res = add(res, base);
       // cout << res << ' ' << base << endl;
        cout << l << endl; cin >> l1 >> r1;
        cout << r << endl; cin >> l2 >> r2;
        if (r1 == "0" || r2 == "0") break;
        l = l1; r = l2;
    }
    if (l1 != "0") res = add(res, "1");
    if (r1 != "0") res = add(res, "1");
    if (l2 != "0") res = add(res, "1");
    if (r2 != "0") res = add(res, "1");
    //cout << "Answer " << res << endl;
    if (l1 == "0" && l2 == "0") {
        cout << 1 << endl;
        cin >> l >> r;
        while (1) {
            cout << r << endl;
            cin >> l >> r;
            if (r == "0") break;
        }
        if (l != "0") res = sub(res, "1");
    }
   // res = sub("15", "1");
    cout << "Answer " << res << endl;
}
