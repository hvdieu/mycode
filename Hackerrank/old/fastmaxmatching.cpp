#include "iostream"
#include "stdio.h"
#include "stdlib.h"
#include "string"
#include "string.h"
#include "algorithm"
#include "math.h"
#include "vector"
#include "map"
#include "queue"
#include "stack"
#include "deque"
#include "set"
using namespace std;

typedef pair<int, int> ii;
typedef vector<int> vi;
typedef vector<ii> vii;
const int inf = 1e9;
const int MaxN = 1e5;

vector<vi> Adj;
int n, m, match[MaxN+4], dist[MaxN+4],u,v;

bool bfs() {
    queue<int> Q;
    for (int i = 1; i <= n; ++i) {
        if (match[i] == 0) {
            dist[i] = 0;
            Q.push(i);
        }
        else dist[i] = inf;
    }
    dist[0] = inf;
    while (!Q.empty()) {
        int u = Q.front(); Q.pop();
        if (u != 0) {
            for (int j = 0; j<Adj[u].size(); ++j) {
                int v=Adj[u][j];
                if (dist[match[v]] == inf) {
                    dist[match[v]] = dist[u] + 1;
                    Q.push(match[v]);
                }
            }
        }
    }
    return (dist[0] != inf);
}

bool dfs(int u) {
    if (u != 0) {
        for (int j = 0; j<Adj[u].size(); ++j) {
            int v = Adj[u][j];
            if (dist[match[v]] == dist[u] + 1) {
                if (dfs(match[v])) {
                    match[v] = u;
                    match[u] = v;
                    return true;
                }
            }
        }
        dist[u] = inf;
        return false;
    }
    return true;
}

void hopcroft_karp() {
    vii result;int matching = 0;
    while (bfs())
    for (int i = 1; i <= n; i++)
        if (match[i] == 0 && dfs(i))
            matching++;
    printf("%d\n", matching);
    for (int  i=1;i<=n;i++)
    if (match[i] != 0) printf("%d %d\n",i,match[i]-n);
}

int main() {
    freopen("input.txt", "r", stdin);
    scanf("%d%d", &n, &m);
    Adj.assign(MaxN+4,vi());
    while (scanf("%d%d",&u,&v)!=EOF){
        v += n;
        Adj[u].push_back(v);
        Adj[v].push_back(u);
    }
    hopcroft_karp();
    return 0;
}

