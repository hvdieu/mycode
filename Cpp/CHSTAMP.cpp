#include <vector>
#include <algorithm>
#include <math.h>
#include <stdio.h>
#include <queue>

using namespace std;

const int N = 200000 + 10;
const int M = 50000 + 10;

class day {
public:
    int t, a, b;
    bool operator < (day x) const {
        return t < x.t;
    }
};

int ntest, n, m, w[N], f[N];
day e[M];
vector<int> ke[N];
priority_queue< pair<int, int>, vector< pair<int, int> > > pq;

int main() {
    //freopen("input.txt", "r", stdin);
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d", &n, &m);
        for(int i = 1; i <= n; i++) scanf("%d", w + i);
        for(int i = 1; i <= m; i++) scanf("%d%d%d", &e[i].t, &e[i].a, &e[i].b);
        sort(e + 1, e + m + 1);
        for(int i = 1; i <= N; i++) f[i] = i;
        for(int i = m; i > 0; ) {
            int j = i;
            while (j && e[j-1].t == e[i].t) j--;
            {
                for(int k = j; k <= i; k++) {
                    pq.push(make_pair(f[e[k].a], e[k].a));
                    pq.push(make_pair(f[e[k].b], e[k].b));
                    ke[e[k].a].push_back(e[k].b);
                    ke[e[k].b].push_back(e[k].a);
                }
                while (!pq.empty()) {
                    int u = pq.top().second, val = pq.top().first;
                    pq.pop();
                    if (f[u] == val)
                        for(int v : ke[u]) if (f[v] < f[u]) {
                            f[v] = f[u];
                            pq.push(make_pair(f[v], v));
                        }
                }
                for(int k = j; k <= i; k++) {
                    ke[e[k].a].pop_back();
                    ke[e[k].b].pop_back();
                }
                i = j - 1;
            }
        }
        long long res = 0;
        for(int i = 1; i <= n; i++) res += f[w[i]];
        printf("%lld\n", res);
    }
}
