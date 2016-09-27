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

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 100010

struct node {
    int val,pos;
};

int ntest,n,a[N],f[N][20],vmax,bot,top,sa[N],lcp[N],pos[N],tmp[N],gap;
char s[N];
node q[N];

bool cmp(node a, node b) {
    return (a.val != b.val) ? (a.val < b.val) : (a.pos < b.pos);
}

void init() {
    n = strlen(s+1);
    vmax = trunc(log(n) / log(2));
    For(i,1,n) {
        a[i] = a[i-1];
        if (s[i] == '(') a[i]++; else a[i]--;
        q[i].val = a[i]; q[i].pos = i;
        f[i][0] = a[i];
    }
    For(j,1,vmax) For(i,1,n - (1 << j) + 1) {
        f[i][j] = min(f[i][j-1], f[i + (1 << (j-1))][j-1]);
    }
    sort(q+1,q+n+1,cmp);
}

bool sufCmp(int i,int j) {
    if (pos[i] != pos[j]) return pos[i] < pos[j];
    i += gap; j += gap;
    return (i <= N && j <= N) ? pos[i] < pos[j] : i > j;
}

void buildSA() {
    For(i,1,n) {
        sa[i] = i; pos[i] = s[i];
        tmp[i] = 1;
    }
    for(gap = 1;;gap *= 2) {
        sort(sa+1,sa+1+n,sufCmp);
        For(i,1,n-1) tmp[i+1] = tmp[i] + sufCmp(sa[i],sa[i+1]);
        For(i,1,n) pos[sa[i]] = tmp[i];
        if (tmp[n] == n) break;
    }
}

void buildLCP() {
    lcp[1] = 0;
    int q = 0;
    For(i,1,n) if (pos[i] != 1) {
        int j = sa[pos[i]-1];
        while (s[i + q] == s[j + q]) q++;
        lcp[pos[i]] = q;
        if (q) q--;
    }
}

int get(int i, int j) {
    int k = trunc(log(j-i+1) / log(2));
    return min(f[i][k],f[j - (1 << k) + 1][k]);
}

int find(int d,int c,int key) {
    int mid,ans = 0, i = d;
    while (d <= c) {
        mid = (d + c) / 2;
        int x = get(i,mid);
        if (x >= key) {
            ans = mid; d = mid + 1;
        } else c = mid - 1;
    }
    return ans;
}

int query(int i,int j,int key) {
    int d = 1, c = n, u = 0, v = 0, mid, ans;
    while (d <= c) {
        mid = (d + c) / 2;
        if (q[mid].val == key) {
            if (q[mid].pos >= i) {
                u = mid; c = mid - 1;
            } else d = mid + 1;
        } else if (q[mid].val < key) d = mid + 1;
        else c = mid - 1;
    }
    if (!u) return 0;
    d = 1; c = n;
    while (d <= c) {
        mid = (d + c) / 2;
        if (q[mid].val == key) {
            if (q[mid].pos <= j) {
                v = mid; d = mid + 1;
            } else c = mid - 1;
        } else if (q[mid].val < key) d = mid + 1;
        else c = mid - 1;
    }
    return v - u + 1;
}

void solve() {
    ll res = 0;
    For(i,1,n) if (s[i] == '(') {
        int d = i + lcp[pos[i]], c = find(i,n,a[i-1]);
        if (d <= c) res += query(d,c,a[i-1]);
    }
    printf("%lld\n",res);
}

int main() {
    //freopen("dbracket.inp","r",stdin);
   // freopen("dbracket.out","w",stdout);
    scanf("%d\n",&ntest);
    while (ntest) {
        ntest--;
        scanf("%s\n",(s+1));
        init();
        buildSA();
        buildLCP();
        solve();
    }
}
