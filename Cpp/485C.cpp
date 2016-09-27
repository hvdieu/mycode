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
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1LL << i))

ll L, R;
int n;

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n;
    while (n) {
        n--;
        cin >> L >> R;
        For(i, 0, 61) if (!bit(L, i) && L + two(i) <= R)
		L += two(i);
        cout << L << endl;
    }
}
