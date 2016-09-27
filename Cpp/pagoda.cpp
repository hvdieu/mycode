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
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()
#define N 200010

string a, b, c, p, q, d, e;
int n, dem[10], res[N], dd[10];

bool check(int len) {
    For(ch, 0, 9) dd[ch] = dem[ch];
    For(j, 0, n-len-2) {
        int x = q[j] - '0';
        For(ch, 0, 9) if (ch > x) return false;
        else if (dd[ch]) {
            if (ch < x) return true;
            dd[ch]--;
            break;
        }
    }
    Rep(j, len, 0) {
        int x = q[n-j-1] - '0';
        if (res[j] < x) return true;
        if (res[j] > x) return false;
    }
    return false;
}

void duyet(int i, int ok) {
    if (i == n) {
        For(j, 0, n-1) printf("%d", res[j]);
        exit(0);
    }
    int bound;
    if (ok) bound = 0; else bound = p[i] - '0';
    For(j, bound, 9) if (dem[j]) {
        int ok1; if (ok || j > bound) ok1 = 1; else ok1 = 0;
        res[i] = j;
        dem[j]--;
        if (check(i)) duyet(i+1, ok1);
        dem[j]++;
    }
    printf("-1"); exit(0);
}

int main() {
    freopen("10.in","r",stdin);
    freopen("pagoda.out","w",stdout);
    scanf("%d\n", &n);
    cin >> a; cin >> b; cin >> c;
    if (a > b) p = a; else p = b;
    Rep(i, n-1, 0) {
        d += a[i]; e += b[i];
    }
    if (d < e) q = d; else q = e;
    For(i, 0, n-1) dem[c[i] - '0']++;
    duyet(0, 0);
}


