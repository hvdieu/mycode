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
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))

int main() {
    //freopen("","r",stdin);
    freopen("input.txt","w",stdout);
    int n = 10, m = 20;
    cout << n << ' ' << m << endl;
    For(i, 1, n) cout << rand() % 10; cout << endl;
    For(i, 1, m) {
        int kind = (rand() % 2) + 1;
        if (kind == 1) {
            int u = rand() % n + 1;
            int v = rand() % 10;
            printf("%d %d %d\n", kind, u, v);
        } else {
            int u = rand() % n + 1;
            int v = rand() % n + 1;
            if (u > v) swap(u, v);
            printf("%d %d %d\n", kind, u, v);
        }

    }
}




