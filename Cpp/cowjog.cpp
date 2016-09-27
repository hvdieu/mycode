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
#include <cmath>

using namespace std;
typedef pair<int, int> cow;
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
#define N 100010
#define eps 1e-12

struct node {
    int i;
    double val;
    node(double a, int b) {
        val = a; i = b;
    }
};

bool operator > (const node &a, const node &b) {
    return a.val > b.val;
}

int n, pos[N], speed[N], res, root[N], f[N];
double t, tt;
bool was[N];
priority_queue< node, vector<node>, greater<node> > heap;

double giao(int i, int j) {
    double dis = pos[j] - pos[i];
    double v = speed[i] - speed[j];
    return dis / v;
}

int getroot(int u) {
    return root[u] != u ? root[u] = getroot(root[u]) : root[u];
}

void Union(int r1, int r2) {
    if (f[r1] < f[r2]) {
        f[r2] += f[r1];
        root[r1] = r2;
    } else {
        f[r1] += f[r2];
        root[r2] = r1;
    }
}

int main() {
    freopen("cowjog.in","r",stdin);
    //freopen("cowjog.out","w",stdout);
    scanf("%d%lf", &n, &t);
    For(i, 1, n) {
        scanf("%d%d", &pos[i], &speed[i]);
        root[i] = i;
        f[i] = 1;
    }
    int i = 1;
    while (i <= n) {
        int j = i;
        while (j < n && speed[j] > speed[j+1]) j++;
        res++; tt = 0;
        while (!heap.empty()) heap.pop();
        For(k, i, j-1) {
            double x = giao(k, k+1);
            if (x <= t) heap.push(node(x, k));
        }
        while (!heap.empty()) {
            double tg = heap.top().val;
            int u = heap.top().i; heap.pop();
            if (!was[u]) {
                tt = tg;
                was[u] = true;
                int r1 = getroot(u), r2 = getroot(u+1);
                if (r1 != r2) Union(r1, r2);
                if (u > i && !was[u-1]) {
                    double dis = double(pos[u]) + tt * speed[u] - double(pos[u-1]) - tt * speed[u-1];
                    speed[u] = speed[u+1];
                    double v = speed[u-1] - speed[u];
                    if (tt + dis / v <= t) heap.push(node(tt + dis/v, u-1));
                }
            }
        }
        For(k, i+1, j) if (getroot(k) != getroot(k-1)) res++;
        i = j+1;
    }
    cout << res;
}




