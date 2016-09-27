#include <bits/stdc++.h>

#define mp make_pair
#define pb push_back
#define fi first
#define se second
#define all(x) x.begin(), x.end()
#define rall(x) x.rbegin(), x.rend()
#define sz(a) int(a.size())
#define reset(a, x)  memset(a, x, sizeof(a))

#define FOR(i, a, b) for(int i=a; i<=b;i++)
#define FORD(i, a, b) for(int i=a; i>=b;i--)

using namespace std;

typedef long long ll;
typedef pair<int, int> pii;
typedef vector<int> vi;
typedef vector<pii> vii;

#define oo 1000000007;
#define eps 1E-9;

const int maxn = 500, maxm = 5000;

queue <int> q;
int n;
int a[maxn][maxn], f[maxn][maxn];
int delta[maxn], trace[maxn];

void OpenFile()
{
    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);
}

void Enter()
{
    int r, c, k;
    scanf("%d%d%d", &r, &c, &k);
    n = r + c + 2;
    FOR(i, 1, r) scanf("%d", &a[1][i+1]);
    FOR(i, 1, c) scanf("%d", &a[r+i+1][n]);
    FOR(i, 1, k){
        int u, v;
        scanf("%d%d", &u, &v);
        a[u+1][v+r+1] = oo;
    }
}

bool FindPath()
{
    queue <int> q;
    int u, v;
    reset(trace, 0);
    q.push(1);
    delta[1] = oo;
    do
    {
        u = q.front(); q.pop();
        FOR(v, 1, n)
            if (trace[v] == 0){
                if (f[u][v] < a[u][v]){
                    trace[v] = u;
                    delta[v] = min(delta[u], a[u][v] - f[u][v]);
                }
                if (f[v][u] > 0){
                    trace[v] = -u;
                    delta[v] = min(delta[u], f[v][u]);
                }
                if (trace[v] != 0){
                    if (v == n) return true;
                    q.push(v);
                }
            }
    } while (!q.empty());
    return false;
}

void IncFlow()
{
    int u, v;
    v = n;
    while(v!= 1){
        u = trace[v];
        if (u > 0) f[u][v] += delta[n];
        else{
            u = -u;
            f[v][u] -= delta[n];
        }
        v = u;
    }
}

void Solve()
{
    while (FindPath()) 
	IncFlow();
}

void Output()
{
    int i, w;
    w = 0;
    FOR(i, 1, n)
        if (a[1][i] > 0) w += f[1][i];
    cout << w<<endl;
}

int main()
{
    OpenFile();
    Enter();
    Solve();
    Output();
}
