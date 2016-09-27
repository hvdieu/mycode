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
#include <map>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef vector<int> VI;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define two(i) (ll(1) << i)
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 10

struct node {
    int val;
    VI q;
    node(int a, VI b) {
        val = a; q = b;
    }
};

bool operator > (node a, node b) {
   	return a.val > b.val;
}

int n, a[N], c[N][N];
priority_queue<node, vector<node>, greater<node> > heap;
vector<int> start, finish;
map<VI, int> ff;
map<VI, int>::iterator it;

void solve() {
    For(i, 1, n) {
        int x = 0;
        For(j, 1, n) if (a[j] <= a[i]) x++;
        start.pb(x);
        finish.pb(i);
    }

    heap.push(node(0, start));
    ff[start] = 0;
    while (!heap.empty()) {
        int gt = heap.top().val; VI q = heap.top().q;
        heap.pop();
      //  cout << gt << ' ';
     //   For(i, 0, n-1) cout << q[i] << ' '; cout << endl;
        if (q == finish) {
            cout << gt;
            return;
        }
        if (gt == ff[q])
        For(i, 1, n) For(j, i+1, n) {
            swap(q[i-1], q[j-1]);

            it = ff.find(q);
            if (it == ff.end() || ff[q] > gt + c[i][j]) {
                ff[q] = gt + c[i][j];
                heap.push(node(gt + c[i][j], q));
            }

            swap(q[i-1], q[j-1]);
        }
    }
}

int main() {
    //freopen("SORT.INP","r",stdin);
    //freopen("SORT.OUT","w",stdout);
    while (1) {
        int x; char c;
        scanf("%d%c", &x, &c);
        a[++n] = x; if (c == '\n') break;
    }
    For(i, 1, n) For(j, 1, n) scanf("%d", &c[i][j]);
    solve();
  //  cout << ff[finish];
}

