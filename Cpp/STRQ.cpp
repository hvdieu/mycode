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
#define N 1000010

char s[N];
int n, a[N], ntest, t[N][4];
ll S[N][4][4];

int ord(char ch) {
    if (ch == 'c') return 0;
    if (ch == 'h') return 1;
    if (ch == 'e') return 2; return 3;
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%s\n", s+1);
    n = strlen(s+1);
    For(i, 1, n) {
        a[i] = ord(s[i]);
        For(j, 0, 3) t[i][j] = t[i-1][j]; t[i][a[i]]++;
        For(c1, 0, 3) For(c2, 0, 3) {
            S[i][c1][c2] = S[i-1][c1][c2];
            if (c1 == a[i]) S[i][c1][c2] += t[i][c2];
        }
    }
    scanf("%d\n", &ntest);
    For(test, 1, ntest) {
        char ch1, ch2;
        int l, r, c1, c2;
        scanf("%c %c %d %d\n", &ch1, &ch2, &l, &r);
        c1 = ord(ch1); c2 = ord(ch2);
        ll res = S[r][c2][c1] - S[l-1][c2][c1] - ll(t[l-1][c1])*(t[r][c2] - t[l-1][c2]);
        printf("%lld\n", res);
    }
}
