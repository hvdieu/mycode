#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
#include <queue>
#include <stack>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define when first
#define time second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define two(i) (ll(1) << i)
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 100010

struct node {
    int x, y;
    node(int a, int b) {
        x = a; y = b;
    }
};

bool operator > (node a, node b) {
    return a.y > b.y;
}

int n;
ii a[N];
ll t, res;
priority_queue<node, vector<node>, greater<node> > heap;

void solve() {
    sort(a+1, a+n+1);
    int i = 1;
    while (i <= n) {
        t = a[i].when;
        heap.push(node(a[i].when, a[i].time));
        i++;
        while (!heap.empty()) {
            int x = heap.top().x, y = heap.top().y;
            heap.pop();
            t += y; res += t - x;
            while (i <= n && a[i].when <= t) {
                heap.push(node(a[i].when, a[i].time));
                i++;
            }
        }
    }
    cout << res / n;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) scanf("%d%d", &a[i].when, &a[i].time);
    solve();
}
