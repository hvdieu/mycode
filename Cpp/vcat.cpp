#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define p first
#define c second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 1010
#define inf 1000000000

int n, t;
ii a[N];
int res, last, flag;

bool can(int x) {
    if (x <= 2*t+1) return true;
    return false;
}

bool chuyen(int x) {
    return t - (x)/2;
}

int main() {
    ios_base::sync_with_stdio(false);
    freopen("vcat.inp","r",stdin);
    freopen("vcat.out","w",stdout);
    cin >> n >> t;
    For(i, 1, n) cin >> a[i].p >> a[i].c;
    sort(a+1, a+n+1);
    last = -inf;
    flag = 1;
    int i = 1;
    if (can(a[1].c)) last = a[i].p - chuyen(a[i].c) + (a[i].c)/2;
    else {
        last = a[i].p + t; res++;
        flag = 0;
    }
    For(i, 2, n) {
        int x = a[i].p;
        int c = a[i].c;
        int left = x - t, right = x + t;
        if (abs(x-last) <= t && !flag) continue;
        if (!can(c)) {
            if (flag) {
                last = right; flag = 0; res++;
            } else if (abs(x-last) > t) {
                res++; last = x + t;
            }
        } else {
            left = x - (c) / 2 + chuyen(c);
            right = x + (c) / 2 + chuyen(c);
            if (left > last) {
                last = last + c; flag = 1;
            } else {
                if (!flag) {
                    if (x-t < last) last = x-t;
                    else {
                        res++; last = x + t;
                    }
                } else {
                    res++; last = x + t;
                }
            }
        }
    }
    cout << res;
}
