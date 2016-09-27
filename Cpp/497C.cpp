#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#include <queue>
#include <stack>

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
#define N 100010

struct play {
    int first, last, cnt, id;
};

struct game {
    int fi, se, id;
};

int n, m, res[N];
game a[N];
play b[N];
map<int, vector<ii> > ff;
map<int, vector<ii> >::iterator it;
vector<ii> q;

bool cmp(game a, game b) {
    if (a.fi != b.fi) return a.fi < b.fi;
    return a.se < b.se;
}

bool cmp2(play a, play b) {
    if (a.first != b.first) return a.first < b.first;
    return a.last < b.last;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("","w",stdout);
    scanf("%d", &n);
    For(i, 1, n) {
        scanf("%d%d", &a[i].fi, &a[i].se);
        a[i].id = i;
    }
    scanf("%d", &m);
    For(i, 1, m) {
        scanf("%d%d%d", &b[i].first, &b[i].last, &b[i].cnt);
        b[i].id = i;
    }
    sort(a+1, a+n+1, cmp);
    sort(b+1, b+m+1, cmp2);
    bool flag = true;
    int j = 1;
    For(i, 1, n) {
        while (j <= m && b[j].first <= a[i].fi) {
            ff[b[j].last].pb(ii(b[j].cnt, b[j].id));
            j++;
        }
        it = ff.lower_bound(a[i].se);
        if (it == ff.end()) {
            flag = false;
            break;
        }
        int k = sz(it->se);
        res[a[i].id] = it->se[k-1].se;
        it->se[k-1].fi--;
        if (!it->se[k-1].fi) it->se.pop_back();
        if (!sz(it->se)) ff.erase(it);
    }
    if (!flag) printf("NO");
    else {
        printf("YES\n");
        For(i, 1, n) printf("%d ", res[i]);
    }
}




