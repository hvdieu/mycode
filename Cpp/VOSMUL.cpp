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
#define NN 31700

int n,m,a[N];
ii b[N];
int prime[NN],pos[NN],dem;
vector<int> p;
vector<ii> q[N];
ll res;

void Sieve() {
    prime[1]=1;
    For(i,2,sqrt(NN))
     if (!prime[i]) {
        For(j,i,NN/i) prime[i*j]=1;
     }
    For(i,2,NN) if (!prime[i]) p.pb(i);
}

int find(int key) {
    int d=1, c=m, mid;
    while (d<=c) {
        mid = (d+c)/2;
        if (b[mid].fi==key) return mid;
        if (b[mid].fi>key) c=mid-1;
         else d=mid+1;
    }
    return 0;
}

void push(int i) {
        For(j,0,sz(q[i])-1) {
            int x=q[i][j].fi;
            if (x<=NN) { if (pos[x]) {
                int y=b[pos[x]].se-q[i][j].se;
                if (b[pos[x]].se>0 && y<=0) dem--;
                b[pos[x]].se -= q[i][j].se;
            } } else {
                int jj=find(x);
                if (jj!=0) {
                    int y=b[jj].se-q[i][j].se;
                    if (b[jj].se>0 && y<=0) dem--;
                    b[jj].se -= q[i][j].se;
                }
            }
        }
}

void pop(int i) {
        For(j,0,sz(q[i])-1) {
            int x=q[i][j].fi;
            if (x<=NN) { if (pos[x]) {
                int y=b[pos[x]].se+q[i][j].se;
                if (b[pos[x]].se<=0 && y>0) dem++;
                b[pos[x]].se += q[i][j].se;
            } } else {
                int jj=find(x);
                if (jj!=0) {
                    int y=b[jj].se+q[i][j].se;
                    if (b[jj].se<=0 && y>0) dem++;
                    b[jj].se += q[i][j].se;
                }
            }
        }
}

bool check(int j) {
    pop(j);
    if (dem==0) return true;
    push(j);
    return false;
}

void solve() {
    sort(b+1,b+1+m);
    For(i,1,m)
	 if (b[i].fi<=NN) pos[b[i].fi]=i;
    Sieve();
    dem=m;
    int j=1;
    For(i,1,n) {
        int x=a[i];
        For(j,0,sz(p)-1) if (!(x%p[j])) {
            int mu=0;
            while (!(x%p[j])) {x/=p[j]; mu++; }
            q[i].pb(ii(p[j],mu));
            if (x==1) break;
        }
        if (x!=1) q[i].pb(ii(x,1));
        push(i);
        if (!dem) {
            while (check(j)) j++;
            res += j;
        }
    }
    cout << res;
}

int main() {
    freopen("VOSMUL.INP","r",stdin);
    freopen("VOSMUL.OUT","w",stdout);
    scanf("%d%d",&n,&m);
    For(i,1,n) scanf("%d",&a[i]);
    For(i,1,m) scanf("%d%d",&b[i].fi,&b[i].se);
    solve();
}


