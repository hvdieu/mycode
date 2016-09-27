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
#define N 110

struct Query {
    int kind,l,r,x,id;
    Query(int a,int b,int c,int d,int e) {
        kind = a; l = b; r = c; x = d; id = e;
    }
};

int n,q,a[N],s[N];
vector <Query> Q;
ll dp[10010],M,kq[10010];
int t[10010],dd[10010],sl;

bool cmp(Query A,Query B) {
    return ((A.l < B.l) || (A.l==B.l && A.r < B.r));
}

void update(int i,int val) {
    while (i <= 10000) {
        t[i] += val;
        i += i & (-i);
    }
}

int get(int i) {
    int s = 0;
    while (i) {
        s += t[i];
        i -= i & (-i);
    }
    return s;
}

int Query0(int x) {
    int d=1, c = 10000, mid,ans=0,SL;
    while (d <= c) {
        mid = (d+c)/2;
        SL = mid - get(mid);
        if (SL >= x) {
            ans = mid;
            c = mid-1;
        } else d=mid+1;
    }
    if (ans) return ans;
    return x+sl;
}

ll Query1(int x) {
    if (x > 10000) return 0;
    if (!x) return dp[x]-1;
    return dp[x];
}

void cc(int u, int v, int L, int R) {
            For(i,u,v) {
                Rep(sum,s[R]-s[L-1],a[i]) {
                    ll RR = dp[sum] + dp[sum-a[i]];
                    if (RR >= M) RR %= M;
                    dp[sum] = (ll(dp[sum]) + dp[sum-a[i]]) % M;
                    if (dd[sum-a[i]] && (!dd[sum])) {
                        dd[sum] = 1; sl++;
                        update(sum,1);
                    }
                }
            }
}

void solve() {
    int last=0;
    sort(Q.begin(),Q.end(),cmp);
    For(k,0,sz(Q)-1) {
        int L = Q[k].l, R = Q[k].r, X = Q[k].x;
        if (L!=last) {
            last = L;
            memset(dp,0,sizeof(dp));
            memset(t,0,sizeof(t));
            memset(dd,0,sizeof(dd));
            sl = 0;
            dp[0] = 1; dd[0] = 1;
            cc(L,R,L,R);
        } else cc(Q[k-1].r+1,R,L,R);
        if (Q[k].kind) kq[Q[k].id] = Query1(Q[k].x);
            else kq[Q[k].id] = Query0(Q[k].x);
    }
    For(i,1,q) printf("%lld\n",kq[i]);
}

int main() {
    freopen("BLSUMSEQ.INP","r",stdin);
    freopen("BLSUMSEQ.OUT","w",stdout);
    cin >> n >> q;
    M = (ll(1) << 32);
    For(i,1,n) {
        cin >> a[i];
        s[i] = s[i-1] + a[i];
    }
    For(i,1,q) {
        int a1,b1,c1,d1;
        cin >> a1 >> b1 >> c1 >> d1;
        Q.push_back(Query(a1,b1,c1,d1,i));
    }
    solve();
}


