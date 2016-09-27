#include <bits/stdc++.h>
#include <chrono>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))
#define N 210

int n, m, lab[N], kq[N], res, dem[N][2], ans, number;
vector<int> ke[N];
vector<int> l[2];

std::chrono::nanoseconds markedTime;

std::chrono::nanoseconds getCurrentTime() {
    return std::chrono::system_clock::now().time_since_epoch();
}

unsigned getElapsedMillisecond() {
    auto&& current = getCurrentTime();
    return std::chrono::duration_cast<std::chrono::milliseconds>(current - markedTime).count();
}

void dfs(int u, int t) {
    lab[u] = t; l[t].pb(u);
    FOR(v, ke[u]) if (lab[*v] < 0)
        dfs(*v, 1-t);
}

void cal() {
    reset(dem, 0); ans = 0;
    For(u, 1, n) FOR(v, ke[u])
        if (lab[u] == lab[*v]) dem[u][0]++;
        else dem[u][1]++, ans += 1;
}

void optimize() {
	bool stop = false;
    while (!stop) {
    	stop = true;
        For(u, 1, n) if (dem[u][0] > dem[u][1]) {
            ans = ans - dem[u][1] + dem[u][0];
        	swap(dem[u][0], dem[u][1]);
            lab[u] = 1 - lab[u];
            FOR(v, ke[u]) if (lab[*v] == lab[u]) dem[*v][0]++, dem[*v][1]--, ans--;
            else dem[*v][0]--, dem[*v][1]++, ans++;
		}
    }
    if (ans > res) {
        res = ans; number = 0;
        For(i, 1, n) kq[i] = lab[i], number += kq[i];
    }
}

void inkq() {
    cout << res/2 << endl;
    cout << number << endl;
    For(i, 1, n) if (kq[i]) cout << i << ' ';
}

void solve() {
    For(i, 1, n) {
        reset(lab, -1);
        l[0].clear(); l[1].clear();
        dfs(i, 0);
        cal();
        optimize();
    }
}

void solve2() {
    while (true) {
        if (getElapsedMillisecond() > 9900) return;
        For(i, 1, n) lab[i] = rand() % 2;
        cal();
        optimize();
    }
}

int main() {
    markedTime = getCurrentTime();
    srand(time(NULL));
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d", &n, &m);
    For(i, 1, m) {
        int u, v;
        scanf("%d%d", &u, &v);
        ke[u].pb(v); ke[v].pb(u);
    }
 //   solve;
    solve2();
    inkq();
}


