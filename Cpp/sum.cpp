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
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 100010

int m,n,a[N],ntest,t[N],res,temp;
ll s[N],k;
lli b[N],c[N];

int id(int i,int j) {
    return (i-1) * n + j;
}

void xoay() {
    int b[N];
    For(i,1,m) For(j,1,n) b[id(j,i)] = a[id(i,j)];
    For(i,1,m*n) a[i] = b[i];
    swap(m,n);
}

ll sum(int i,int l,int r) {
    if (l == 1) return s[id(i,r)];
    return s[id(i,r)] - s[id(i,l-1)];
}

void mergesort(int l,int r) {
    if (l == r) return;
    int mid = (l + r) / 2;
    mergesort(l,mid); mergesort(mid+1,r);
    t[l] = b[l].se;
    For(i,l+1,mid) t[i] = max(t[i-1],b[i].se);
    int j = l-1;
    For(i,mid+1,r) {
        while (j < n && b[j+1].fi <= b[i].fi - k) j++;
        if (j >= l) temp = min(temp,b[i].se - t[j]);
    }
    int i = l, dem = 0; j = mid + 1;
    while (1) {
        if (i > mid && j > r) break;
        if (i > mid) {
            c[++dem] = b[j]; j++;
        } else if (j > r) {
            c[++dem] = b[i]; i++;
        } else {
            if (b[i].fi > b[j].fi) {
                c[++dem] = b[j]; j++;
            } else {
                c[++dem] = b[i]; i++;
            }
        }
    }
    For(i,l,r) b[i] = c[i-l+1];
}

void solve() {
    if (m < n) xoay();
    res = m*n+1;
    For(i,1,m) {
        s[id(i,1)] = a[id(i,1)];
        For(j,2,n) s[id(i,j)] = s[id(i,j-1)] + a[id(i,j)];
    }
    For(l,1,n) For(r,l,n) {
        b[0] = lli(0,0);
        For(i,1,m) b[i] = lli(b[i-1].fi + sum(i,l,r),i);
        temp = m*n+1;
        mergesort(0,m);
        res = min(res,temp * (r-l+1));
    }
    if (res == m*n+1) printf("-1\n");
    else printf("%d\n",res);
}

int main() {
    freopen("50.inp","r",stdin);
    freopen("sum.out","w",stdout);
    scanf("%d",&ntest);
    while (ntest) {
        ntest--;
        scanf("%d %d %lld",&m,&n,&k);
        For(i,1,m) For(j,1,n) scanf("%d",&a[id(i,j)]);
        solve();
    }
}
