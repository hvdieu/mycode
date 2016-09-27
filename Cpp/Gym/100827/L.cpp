#include <bits/stdc++.h>

using namespace std;

const int N = 60 + 1;

struct planet {
    string name;
    int x, y, z;
};

const double inf = 1e15;

int ntest, n, m, q;
planet p[N];
double dis[N][N];
map<string, int> id;

double cal(int i, int j) {
    double xx = p[i].x - p[j].x, yy = p[i].y - p[j].y, zz = p[i].z - p[j].z;
    return sqrt(xx*xx + yy*yy + zz*zz);
}

int main() {
   // freopen("L.inp", "r", stdin);
   // freopen("L.out", "w", stdout);
    cin >> ntest;
    for(int test = 1; test <= ntest; test++) {
        cout << "Case " << test << ":\n";
        cin >> n;
        for(int i = 1; i <= n; i++) {
            cin >> p[i].name >> p[i].x >> p[i].y >> p[i].z;
            id[p[i].name] = i;
        }
        for(int i = 1; i <= n; i++)
            for(int j = 1; j <= n; j++) if (i == j) dis[i][j] = 0; else dis[i][j] = cal(i, j);
        cin >> m;
        for(int i = 1; i <= m; i++) {
            string u, v;
            cin >> u >> v;
            dis[id[u]][id[v]] = 0;
        }
        for(int k = 1; k <= n; k++)
        for(int i = 1; i <= n; i++)
        for(int j = 1; j <= n; j++)
        dis[i][j] = min(dis[i][j], dis[i][k] + dis[k][j]);
        cin >> q;
        while (q) {
            q--;
            string u, v;
            cin >> u >> v;
            cout << "The distance from " << u << " to " << v << " is " << int(round(dis[id[u]][id[v]])) << " parsecs.\n";
        }
    }
}
