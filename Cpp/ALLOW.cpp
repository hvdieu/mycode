#include <stdio.h>
#include <iostream>
#include <algorithm>
using namespace std;
typedef pair<int, int> ii;
#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define N 21
int n,c,salary;
ii coin[N];
int used[N];
void solve() {
    sort(coin+1,coin+n+1);
    int weeks = 0;
    while (1) {
        salary = c;
        Rep(i,n,1)
         if (coin[i].se > 0 && salary - coin[i].fi >= 0) {
             int x = min(salary/coin[i].fi,coin[i].se);
             coin[i].se -= x;
             used[i] += x; salary -= x*coin[i].fi;
         }
        if (salary)
          For(i,1,n)
            if (coin[i].se > 0) {
                used[i]++;
                coin[i].se--;
                salary -= coin[i].fi;
                break;
            }
        if (salary > 0) break;
        int minweek = 1000000000;
        For(i,1,n)
         if (used[i]) minweek = min(minweek,coin[i].se/used[i]);
        For(i,1,n)
         if (used[i]) {
            coin[i].se -= minweek*used[i]; used[i]=0;
         }
        weeks += minweek+1;
    }
    cout << weeks;
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d%d",&n,&c);
    For(i,1,n) scanf("%d%d",&coin[i].fi,&coin[i].se);
    solve();
}

