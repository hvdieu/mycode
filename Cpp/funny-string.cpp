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
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))

string a, b;
bool flag;

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    int ntest;
    cin >> ntest;
    For(test, 1, ntest) {
        bool flag = true;
        cin >> a; b = a; reverse(all(b));
        For(i, 1, sz(a)-1) if (abs(int(a[i] - a[i-1])) != abs(int(b[i] - b[i-1]))) flag = false;
        if (flag) cout << "Funny"; else cout << "Not Funny"; cout << endl;
    }
}
