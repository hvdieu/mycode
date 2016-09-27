#include <bits/stdc++.h>

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
#define N 5010
#define MAX 200001

int n, a[N];
ll cnt[MAX + 10];
ll r1, r2, r3;

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    cin >> n;
    For(i, 1, n) cin >> a[i], cnt[a[i]]++;
    For(i, 1, MAX) cnt[i] += cnt[i-1];
    For(i, 1, n) For(j, i+1, n) {
        int l = a[j] - a[i], r = min(a[i] + a[j], MAX);
        double cc = sqrt(a[i]*a[i] + a[j]*a[j]);
        int c = trunc(cc);
        if (cc == c) {
            r2 += cnt[c] - cnt[c-1];
            if (l < c) r1 += cnt[c-1] - cnt[l];
            if (l < a[i] && a[i] < c) r1--;
            if (l < a[j] && a[j] < c) r1--;
            if (c < r) r3 += cnt[r-1] - cnt[c];
            if (c < a[i] && a[i] < r) r3--;
            if (c < a[j] && a[j] < r) r3--;
        } else {
            if (l < a[i] && a[i] <= c) r1--;
            if (l < a[j] && a[j] <= c) r1--;
            if (l < c) r1 += cnt[c] - cnt[l];
            if (c < r) r3 += cnt[r-1] - cnt[c];
            if (c < a[i] && a[i] < r) r3--;
            if (c < a[j] && a[j] < r) r3--;
        }
    }
    cout << (r1 - r3*2 - r2*2) / 3<< ' ' << r2 << ' ' << r3;
}


