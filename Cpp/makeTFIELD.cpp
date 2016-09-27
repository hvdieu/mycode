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
#define N 5010
#define sub 1
#define ma 101

set<double> ff;
int n, m, k;
ii a[N];

unsigned int random(int x) {
    return ((rand() << 16) | (rand())) % x;
}

void makeRec() {
    int x = random(ma), y = random(ma);
    if (random(2)) x = -x;
    if (random(2)) y = -y;
    int color = random(m) + 1;
    while (1) {
        ll c1 = random(min(ma, ma - x)), c2 = random(min(ma, ma - y));
        if (!c1) c1++;
        if (!c2) c2++;
        if (ff.find(c1*c2) == ff.end()) {
            ff.insert(c1*c2);
            cout << 4 << ' ' << color << ' ';
            cout << x << ' ' << y << ' ' << x + c1 << ' ' << y << ' ' << x + c1 << ' ' << y + c2 << ' ' << x << ' ' << y + c2;
            cout << endl;
            break;
        }
    }
}

int main() {
    //freopen("","r",stdin);
    freopen("TFIELD.INP","w",stdout);
    m = 6;
    k = random(m+1);
    cout << m << ' ' << k << endl;
    For(i, 1, m) {
        if (sub == 1) makeRec();
        //else if (sub == 2) makeTri();
        //else makePolygon();
    }
}
