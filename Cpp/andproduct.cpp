#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#include <queue>
#include <stack>

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
#define two(x) (ll(1) << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))

unsigned int A, B, res;
int ntest;

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        cin >> A >> B;
        res = 0;
        Rep(i, 31, 0) {
            ll y = two(i+1);
            ll x = two(i);
            if (A >= x && B < y) res += two(i);
            if (A >= two(i)) A -= two(i);
            if (B >= two(i)) B -= two(i);
        }
        cout << res << endl;
    }
}




