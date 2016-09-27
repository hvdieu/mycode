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
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 100010

int n, a[N], ma, mi;
char s[N];
deque<int> q;

int main() {
    //ios_base::sync_with_stdio(false);
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> s+1;
    n = strlen(s+1)+1;
    int x = n-1;
    int i = 0; q.push_back(n);
    For(j, 1, n-1) if (s[j] == 'I') q.push_front(x--);
    else {
        while (!q.empty()) { a[++i] = q.front(); q.pop_front(); }
        q.push_back(x--);
    }
    while (!q.empty()) a[++i] = q.front(), q.pop_front();
    For(i, 1, n) cout << a[i] << ' ';
}
