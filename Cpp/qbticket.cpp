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

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 100010
#define inf 1000000000000000LL

int n,l1,l2,l3,c1,c2,c3,s,t;
ll a[N],sum[N],f[N];

int find(int d,int c,ll key) {
    int mid,ans = 0,i = c;
    while (d <= c) {
        mid = (d+c) / 2;
        if (sum[mid] >= key) {
            ans = mid; c = mid - 1;
        } else d = mid+1;
    }
    return ans;
}

void solve() {
    f[s] = 0;
    For(i,s+1,t) {
        f[i] = inf;
        int j;
        ll x = sum[i] - sum[i-1];
        if (x <= l1) {
            j = find(s,i-1,sum[i] - l1);
            f[i] = f[j] + c1;
        }
        if (x <= l2) {
            j = find(s,i-1,sum[i] - l2);
            f[i] = min(f[i],f[j] + c2);
        }
        if (x <= l3) {
            j = find(s,i-1,sum[i] - l3);
            f[i] = min(f[i],f[j] + c3);
        }
    }
    cout << f[t];
}

int main() {
    //freopen("qbticket.inp","r",stdin);
    //freopen("qbticket.out","w",stdout);
    scanf("%d%d%d%d%d%d",&l1,&l2,&l3,&c1,&c2,&c3);
    scanf("%d",&n);
    scanf("%d%d",&s,&t);
    if (s > t) swap(s,t);
    For(i,2,n) scanf("%lld",&sum[i]);
    solve();

}
