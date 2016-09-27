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
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 50

int n, f[50][50][50][50];
queue< vector<int> > q;
vector<int> a, b;

void gan(vector<int> a, int x) {
    sort(all(a));
    For(i, 1, 4-n) a.pb(0);
    f[a[0]][a[1]][a[2]][a[3]] = x;
}

int gt(vector<int> a) {
    sort(all(a));
    For(i, 1, 4-n) a.pb(0);
    return f[a[0]][a[1]][a[2]][a[3]];
}

bool check(vector<int> a, vector<int> b) {
    For(i, 0, n-1) if (a[i] != b[i]) return false;
    return true;
}

void push(vector<int> a) {
    sort(all(a));
    q.push(a);
}

vector<int> pour(vector<int> a, int i, int j) {
    if (a[i] + a[j] > 49) {
        a[j] = 49; a[i] = a[i] + a[j] - 49;
    } else {
        a[j] += a[i]; a[i] = 0;
    }
    return a;
}

void solve() {
    sort(all(a)); sort(all(b));
    reset(f, -1);
    while (!q.empty()) q.pop();
    q.push(a); gan(a, 0);
    while (!q.empty()) {
        vector<int> a = q.front(); q.pop();
        For(i, 0, n-1) cout << a[i] << ' '; cout << endl;
        int x = gt(a);
        if (check(a, b)) {
            cout << x << endl;
            return;
        }
        For(i, 0, n-1) if (a[i]) {
            int temp = a[i];
            a[i] = 0;
            int y = gt(a);
            if (y < 0 || y > x + 1) {
                gan(a, x+1);
                push(a);
            }
            a[i] = temp;
        }

        For(i, 0, n-1) For(j, i+1, n-1) {
            vector<int> c = pour(a, i, j);
            int y = gt(c);
            if (y < 0 || y > x + 1) {
                gan(c, x+1);
                push(c);
            }

            c = pour(a, j, i);
            y = gt(c);
            if (y < 0 || y > x + 1) {
                gan(c, x+1);
                push(c);
            }
        }
    }
    cout << "NO" << endl;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    int ntest;
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        a.clear(); b.clear();
        For(i, 1, n) {
            int x; scanf("%d", &x);
            a.pb(x);
        }
        For(i, 1, n) {
            int x; scanf("%d", &x);
            b.pb(x);
        }
        solve();
    }
}
