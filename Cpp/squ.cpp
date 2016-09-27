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
#define N 310

int n, s[N*N], m, a[N], res;
multiset<int> ff;
multiset<int>::iterator it;
int kq[N][N];

bool del(int i) {
    For(j, 1, i-1) {
        int x = a[i] + a[j];
        it = ff.find(x);
        if (it == ff.end()) return false;
        ff.erase(it);
    }
    return true;
}

void Find(int i) {
    if (i > n) {
        res++;
        For(j, 1, n) kq[res][j] = a[j];
        return;
    }
    it = ff.begin();
    a[i] = *it - a[1];
    if (a[i] <= a[i-1]) return;
    if (del(i)) Find(i+1);
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n); m = (n * (n-1))/2;
    For(i, 1, m) scanf("%d", s+i);
    sort(s+1, s+m+1);
    For(i, 3, n) if (i == 3 || (i > 3 && s[i] != s[i-1])) {
        int x = s[1] + s[2] - s[i];
        if (x < 0) break;
        if (x % 2 == 0) {
            x /= 2;
            a[1] = x;
            ff.clear(); For(j, 1, m) ff.insert(s[j]);
            Find(2);
        }
    }
    printf("%d\n", res);
    For(i, 1, res) {
        For(j, 1, n) printf("%d ", kq[i][j]); printf("\n");
    }
}
