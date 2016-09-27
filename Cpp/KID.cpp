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
#define N 1000010
#define inf 1000000000000000LL
int n, a[N], p1[N], p2[N], top1, top2;
ll s1[N], s2[N];
ll f[N];

int main() {
    freopen("kid.inp","r",stdin);
    freopen("kid.out","w",stdout);
    scanf("%d", &n);
    s1[0] = s2[0] = -inf;
    For(i, 1, n) {
        scanf("%d", &a[i]);
        f[i] = f[i-1];
        while (top1 && a[p1[top1]] >= a[i]) top1--;
        while (top2 && a[p2[top2]] <= a[i]) top2--;
        f[i] = max(f[i], s1[top1] + a[i]);
        f[i] = max(f[i], s2[top2] - a[i]);
        p1[++top1] = i; s1[top1] = max(s1[top1-1], f[i-1] - a[i]);
        p2[++top2] = i; s2[top2] = max(s2[top2-1], f[i-1] + a[i]);
    }
    cout << f[n];
}
