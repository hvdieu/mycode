#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) 1 << x
#define bug(x, i) { return (x >> i) & 1; }
#define N 100010

int a[N], n;

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("capple.out","w",stdout);
    int ntest;
    scanf("%d", &ntest);
    while (ntest) {
        ntest--;
        scanf("%d", &n);
        For(i, 1, n) scanf("%d", &a[i]);
        sort(a+1, a+n+1);
        int res = 0;
        For(i, 1, n) if (a[i] != a[i-1]) res++;
        printf("%d\n", res);
    }
}


