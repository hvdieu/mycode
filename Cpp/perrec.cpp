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
#define N 2010

int n,m,a,b,c,d,x[N][N],h[N],res,l[N],r[N],top,p[N],vt[N],s[N][N],dem;
vector<int> ke[N];

void inkq() {
    For(i,1,n) {
        For(j,1,n) cout << x[i][j]; cout << "\n";
    }
}

bool cmp(int i,int j) {
    if (h[i] != h[j]) return h[i] < h[j];
    return i < j;
}

void cal(int i) {
        For(j,1,n) {
            if (x[i][j]) h[j] = 0; else h[j]++;
            ke[h[j]].pb(j);
            s[i+1][j] = s[i+1][j-1] + x[i+1][j];
        }
        l[1] = 1; p[1] = 1; p[0] = 0;
        top = 1;
        For(j,2,n) {
            if (h[j] > h[j-1]) {
                l[j] = 1; p[++top] = j;
            } else {
                while (top && h[j] <= h[p[top]]) top--;
                l[j] = j - p[top]; p[++top] = j;
            }
        }

        r[n] = 1; p[1] = n; p[0] = n+1; top = 1;
        Rep(j,n-1,1) {
            if (h[j] > h[j+1]) {
                r[j] = 1; p[++top] = j;
            } else {
                while (top && h[j] <= h[p[top]]) top--;
                r[j] = p[top] - j; p[++top] = j;
            }
        }
}

int sum(int i,int l,int r) {
    return s[i][r] - s[i][l-1];
}

void xep(int i) {
    dem = 0;
    For(k,1,i) {
        For(j,0,sz(ke[k])-1) {
            dem++; vt[dem] = ke[k][j];
        }
        ke[k].clear();
    }
}

void solve() {
    //inkq();
    For(j,1,n) x[n+1][j] = 1;
    For(i,1,n) {
    	cal(i);
        int left = 0,right = 0,id = 0;
        xep(i);
        For(k,1,dem) {
            int j = vt[k];
            if (h[j]) {
                int lll = j - l[j] + 1, rrr = j + r[j] - 1;
                if ((lll != left || rrr != right) && sum(i+1,lll,rrr)) {
                    left = lll; right = rrr; res++; id = j;
                }
            }
        }
    }
    cout << res;
}

int main() {
    freopen("perrec.inp","r",stdin);
    //freopen("perrec.out","w",stdout);
    int x0,y0;
    cin >> n >> m >> x0 >> a >> b >> y0 >> c >> d;
    x0 %= n; y0 %= n;
    x[x0+1][y0+1] = 1;
    For(i,1,m-1) {
        x0 = x0 * a + b;
        y0 = y0 * c + d;
        if (x0 >= n) x0 %= n;
        if (y0 >= n) y0 %= n;
        x[x0+1][y0+1] = 1;
    }
    solve();
}



