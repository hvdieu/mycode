#include <bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef long double ld;
typedef pair<int,int> pii;
#define mp make_pair
#define pb push_back
#define sz(x) ((int) (x).size())

#define X first
#define Y second


const int maxn = 155;
bool area[maxn][maxn];
int hnum[maxn][maxn];
int vnum[maxn][maxn];
int vdeg[maxn*maxn], hdeg[maxn*maxn];

const int maxV = maxn*maxn + 10;
const int maxE = maxn*maxn*4 + 10;

#define next ___NEXT___
int first[maxV];
int next[maxE], to[maxE], from[maxE], cap[maxE], cost[maxE];
int ecnt;

void add_edge(int u, int v, int _cap, int _cost)
{
    next[ecnt] = first[u];
    to[ecnt] = v;
    from[ecnt] = u;
    cap[ecnt] = _cap;
    cost[ecnt] = _cost;
    first[u] = ecnt;
    ecnt++;
    next[ecnt] = first[v];
    to[ecnt] = u;
    from[ecnt] = v;
    cap[ecnt] = 0;
    cost[ecnt] = -_cost;
    first[v] = ecnt;
    ecnt++;
}

bool inq[maxV];
int q[maxV], dist[maxV], h[maxV];
int push_flow(int S, int T)
{
    for (int i = 0; i <= T; i++) inq[i] = 0, dist[i] = (int)1e9, h[i] = -1;
    int ql = 0, qr = 0;
    dist[S] = 0;
    h[S] = -1;
    q[qr++] = S;
    inq[S] = 1;
    while (ql != qr)
    {
        int cur = q[ql];
        inq[cur] = 0;
        ql++;
        if (ql == maxV) ql = 0;
        for (int i = first[cur]; i != -1; i = next[i])
        {
            if (cap[i] > 0 && dist[to[i]] > dist[cur] + cost[i])
            {
                dist[to[i]] = dist[cur] + cost[i];
                h[to[i]] = i;
                if (!inq[to[i]])
                {
                    q[qr] = to[i];
                    inq[to[i]] = 1;
                    qr++;
                    if (qr == maxV) qr = 0;
                }
            }
        }
    }
    if (dist[T] == (int)1e9) return -1;
    int cur = T;
    int pcost = 0;
    while (h[cur] != -1)
    {
        cap[h[cur]]--;
        cap[h[cur]^1]++;
        pcost += cost[h[cur]];
        cur = from[h[cur]];
    }
    cout << dist[T] << "\n";
    return pcost;
}

int main()
{
    freopen("in.txt", "r", stdin);
    int n,k;
    assert(scanf("%d%d", &n, &k) == 2);
    for (int i = 0; i < n; i++)
       for (int j = 0; j < n; j++)
       {
           char u[3];
           assert(scanf("%1s", u) == 1);
           if (u[0] == '#') area[i][j] = 0;
           else area[i][j] = 1;
       }
    int hcnt = 0, vcnt = 0;
    for (int i = 0; i < n; i++)
       for (int j = 0; j < n; j++)
          if (area[i][j])
          {
              if (j == 0 || !area[i][j-1]) hnum[i][j] = hcnt++;
              else hnum[i][j] = hnum[i][j-1];
          }
    for (int j = 0; j < n; j++)
       for (int i = 0; i < n; i++)
          if (area[i][j])
          {
              if (i == 0 || !area[i-1][j]) vnum[i][j] = vcnt++;
              else vnum[i][j] = vnum[i-1][j];
          }
    int S = hcnt + vcnt;
    int T = hcnt + vcnt + 1;
    cout << hcnt << ' ' << vcnt << "\n";
    ecnt = 0;
    for (int i = 0; i < hcnt; i++) hdeg[i] = 0;
    for (int i = 0; i < vcnt; i++) vdeg[i] = 0;
    for (int i = 0; i < n; i++)
       for (int j = 0; j < n; j++)
          if (area[i][j]) hdeg[hnum[i][j]]++, vdeg[vnum[i][j]]++;
    for (int i = 0; i <= T; i++) first[i] = -1;
    for (int i = 0; i < hcnt; i++)
       for (int j = 0; j < hdeg[i]; j++)
          add_edge(S, i, 1, j);
    for (int i = 0; i < vcnt; i++)
       for (int j = 0; j < vdeg[i]; j++)
          add_edge(i+hcnt, T, 1, j);
    for (int i = 0; i < n; i++)
       for (int j = 0; j < n; j++)
          if (area[i][j])
             add_edge(hnum[i][j], vnum[i][j] + hcnt, 1, 0);
    int res = 0;
    for (int i = 0; i < k; i++)
    {
        int z = push_flow(S, T);
        if (z == -1) assert(false);
        res += z;
        //cout << res << "\n";
    }
    //cout << res << endl;
    return 0;
}
