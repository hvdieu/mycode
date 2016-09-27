#include <bits/stdc++.h>

using namespace std;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define x first
#define y second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 2410
#define pi acos(-1)

struct ii {
    int x, y;
    double goc;
};

int n, xFirst, xAdd, xProd, xMod, yFirst, yAdd, yProd, yMod, m;
ii p[N], origin;
ii p2[N];

void operator -= (ii &A, ii B) {
    A.x -= B.x; A.y -= B.y;
}

inline bool ccw(ii O, ii A, ii B) {
    A -= O; B -= O;
    return ll(A.x) * B.y > ll(A.y) * B.x;
}

double goc(ii A) {
    int x = A.x, y = A.y;
    if (!x) {
        if (!y) return 0;
        if (y > 0) return pi/2;
        else return ((3.0/2)*pi);
    } else if (!y) {
        if (x > 0) return 0;
        return pi;
    }
    double o = abs(atan(double(y)/x));
    if (x > 0) {
        if (y > 0) return o;
        return 2.0*pi - o;
    } else {
        if (y > 0) return pi-o;
        return pi+o;
    }
}

bool cmp(ii A, ii B) {
    A -= origin;
    B -= origin;
    return goc(A) < goc(B);
}

ll res;

inline ll C2(int x) {
    return (ll(x)*(x-1))/2;
}

inline ll C3(int x) {
    return (ll(x) * (ll(x)-1) * (x-2)) / 6;
}

void solve() {
    if (n < 4) {
        cout << 0; return;
    }
    For(i, 1, n) p2[i] = p[i];
    For(i, 1, n) {
        origin = p2[i];
        //printf("Origin = %d %d\n", origin.x, origin.y);
        m = 0; For(j, 1, n) if (i != j) p[++m] = p2[j];
        sort(p+1, p+1+m, cmp);
        int xx;
        //For(i, 1, m-1) {
       //     xx = ccw(origin, p[i], p[i+1]); cout << xx << ' ';
       // }
        //For(i, 1, m) printf("%d %d\n", p[i].x, p[i].y);
        For(i, m+1, 2*m) p[i] = p[i-m];
        ll temp = 0;
        int s1 = 0;
        int j = 1;
        For(k, 1, m) {
            if (k > 1 && ccw(origin, p[k-1], p[k])) s1--;
            //int s2 = 0;
           //For(jj, 1, m) if (jj != k && ccw(origin, p[k], p[jj]))
			//s2++;
            if (j < k) j = k;
           // int xx = ccw(origin, p[9], p[10]);
            while ((j < 2*m) && ccw(origin, p[k], p[j+1])) {j++; s1++;}
            temp += C2(s1);
        }
       // cout << C3(m) - temp << endl;
        res += C3(m) - temp;
    }
    res = ((ll(n)*(ll(n)-1)*(ll(n)-2)*(n-3)) / 24) - res;
    cout << res;
}

int main() {
    //ios_base::sync_with_stdio(false);
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    cin >> n >> xFirst >> xAdd >> xProd >> xMod >> yFirst >> yAdd >> yProd >> yMod;
    p[1] = ii(xFirst, yFirst);
    For(i, 2, n) {
        int xx = (ll(p[i-1].x) * xProd + xAdd) % xMod;
        int yy = (ll(p[i-1].y) * yProd + yAdd) % yMod;
        p[i] = ii(xx, yy);
    }
   // For(i, 1, n) cout << p[i].x << ' ' << p[i].y << endl;
    solve();
}
