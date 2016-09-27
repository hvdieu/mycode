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
#define inf 1000000000
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

int n, res, root[N], f[N];
double t, tt, speed[N], pos[N];
bool was[N];
priority_queue< node, vector<node>, greater<node> > heap;

double giao(int i, int j) {
    if (speed[i] <= speed[j]) return inf;
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
    freopen("cowjog.out","w",stdout);
    scanf("%d%lf", &n, &t);
    For(i, 1, n) {
        scanf("%lf%lf", &pos[i], &speed[i]);
        root[i] = i;
        f[i] = 1;
    }
    tt = 0;
    while (1) {
        double temp = 1000000000;
        int u = 0;
        For(i, 1, n-1) if (!was[i]) {
            double x = giao(i, i+1);
            if (temp > x) {
                temp = x; u = i;
            }
        }
        if (!u) break;
        if (tt + temp > t) break;
        For(i, 1, n) if (!was[i]) pos[i] = pos[i] + temp * speed[i];
        speed[u] = speed[u]+1; was[u] =  true;
        int r1 = getroot(u), r2 = getroot(u+1);
        if (r1 != r2) Union(r1, r2);
        tt += temp;
    }
    res = 1;
    For(i, 2, n) if (getroot(i) != getroot(i-1)) res++;
    cout << res;
}




