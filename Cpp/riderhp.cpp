#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define N 11

int m, n;
ii a[N], goc;

void operator -= (ii &a, ii b) {
    a.x -= b.x; a.y -= b.y;
}

bool ccw(ii O, ii A, ii B) {
    A -= O; B -= O;
    return ll(A.x) * B.y > ll(A.y) * B.x;
}

bool cmp(ii a, ii b) {
    return !ccw(goc, a, b);
}

int main() {
    freopen("riderhp.inp","r",stdin);
  //  freopen("riderhp.out","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d", &a[i].y); a[i].x = i;
    }
    a[0].x = 1; a[0].y = 0;
    a[n+1].x = n; a[n+1].y = 0;
    a[n+2] = a[0];
    goc = a[0];
    sort(a+1, a+n+2, cmp);
    int j = 1;
    For(i, 2, n+2) {
        while (j > 1 && ccw(a[j-1], a[j], a[i])) j--;
        a[++j] = a[i];
    }
    n = j-1;
    int ntest;
    scanf("%d", &ntest);
    while (ntest) {
        ntest--; int s; scanf("%d", &s);
        goc.x = 0; goc.y = s;
        int d = 1, c = n-1, mid, ans;
        while (d <= c) {
            int mid = (d + c) / 2;
            if (ccw(goc, a[mid], a[mid-1]) == ccw(goc, a[mid], a[mid+1])) {
                ans = mid; break;
            } else if (ccw(goc, a[mid], a[mid+1])) d = mid + 1;
            else c = mid - 1;
        }
        double res = double(a[ans].x) / (a[ans].y - s);
        printf("%.6lf\n", res);
    }
}


