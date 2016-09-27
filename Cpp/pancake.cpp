#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
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
#define N 9
#define TT 46323

int n, a[N], d[TT], gt[N], s[N], b[N], dem;
vector<int> permut[TT];
bool fr[N];
bool was[TT];
queue<int> q;

void init(int i, int n) {
    if (i > n) {
        dem++;
        For(j, 1, n) permut[dem].pb(a[j]);
        return;
    }
    For(j, 1, n) if (fr[j]) {
        fr[j] = false;
        a[i] = j;
        init(i+1, n);
        fr[j] = true;
    }
}

int id(int n) {
    reset(fr, true);
    int res = 0;
    For(i, 1, n) {
        For(j, 1, a[i]-1) if (fr[j]) res += gt[n-i];
        fr[a[i]] = false;
    }
    return res + 1;
}

void rev(int i, int j) {
    while (i < j) {
        swap(a[i], a[j]);
        i++; j--;
    }
}

void bfs(int start, int n) {
    q.push(start); was[start] = 1;
    while (!q.empty()) {
        int x = q.front(); q.pop();
        For(i, 1, n) a[i] = permut[x][i-1];
        For(j, 1, n-1) {
            rev(j, n);
            int y = id(n) + s[n-1];
            if (!was[y]) {
                was[y] = 1;
                q.push(y);
                d[y] = d[x] + 1;
            }
            rev(j, n);
        }
    }
}

int main() {
    freopen("pancake.inp","r",stdin);
    freopen("pancake.out","w",stdout);
    gt[0] = 1;
    For(i, 1, 8) {
        gt[i] = gt[i-1] * i;
        s[i] = s[i-1] + gt[i];
    }
    For(i, 1, 8) {
    	reset(fr, true);
        init(1, i);
        bfs(dem, i);
    }
    int ntest;
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n); For(i, 1, n) scanf("%d", &b[i]);
        reset(a, 0);
        For(i, 1, n) For(j, 1, n) if (b[j] <= b[i]) a[i]++;
        printf("%d\n", d[s[n-1] + id(n)]);
    }
}
