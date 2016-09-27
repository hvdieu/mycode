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
#define N 13
#define M 1010

int ntest,n,m,ss,work,s1,s2;
int x[M],y[M],x1[M],c[M];
ll d[4100],inf;

priority_queue <lli, vector<lli>, greater<lli> > pq;

void Dij(){
    For(i,0,(1<<n)-1) d[i]=inf;
    d[s1]=0; pq.push(lli(d[s1],s1));
    while (!pq.empty()) {
        int u=pq.top().se;
        ll du=pq.top().fi;
        pq.pop();
        if (du==d[u]) {
            For(i,1,m) if ((u|x[i])==u) {
                int v=(u&x1[i])|y[i];
                if (d[v]>d[u]+c[i]) {
                    d[v]=d[u]+c[i];
                    pq.push(lli(d[v],v));
                }
            }
        }
    }
    if (d[s2]==inf) printf("NO\n"); else cout << "YES " << d[s2] << "\n";
}

int main() {
    freopen("A.INP","r",stdin);
    freopen("A.OUT","w",stdout);
    scanf("%d",&ntest);
    inf = 1000000000000000000ll;
    int dem=0;
    while (ntest) {
        ntest--;
        dem++;
        printf("Case #%d: ",dem);
        scanf("%d%d",&n,&m);
        s1=0; s2=0;
        int nn,j;
        scanf("%d",&nn);
        For(i,1,nn) {
            scanf("%d",&j); s1=s1|(1 << j);
        }
        scanf("%d",&nn);
        For(i,1,nn) {
            scanf("%d",&j); s2=s2|(1 << j);
        }
        For(i,1,m) {
            scanf("%d",&work); c[i]=work;
            scanf("%d",&nn);
            x[i]=0; y[i]=0; x1[i]=(1 << n)-1;
            For(ii,1,nn) {
                scanf("%d",&j); x[i]=x[i]|(1 << j);
                x1[i]=x1[i]&(~(1<<j));
            }
            scanf("%d",&nn);
            For(ii,1,nn) {
                scanf("%d",&j); y[i]=y[i]|(1<<j);
            }
        }
        Dij();
    }
}


