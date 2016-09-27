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

char s[N],a[20],b[20];
int n,ntest,pos[260],back[N][260],m,l;

int main() {
    freopen("VOSHANDL.INP","r",stdin);
    //freopen("VOSHANDL.OUT","w",stdout);
    cin >> (s+1);
    n = strlen(s+1);
    cin >> ntest;
    For(i,0,255) pos[i] = 0;
    For(i,1,n+1) {
        For(j,0,255) back[i][j] = pos[j];
        if (i<=n) pos[int(s[i])] = i;
    }
    while (ntest) {
        ntest--;
        cin >> (a+1) >> (b+1);
        int i = n+1, u= n+1;
        m = strlen(a+1);
        Rep(j,m,1) {
            i = back[i][int(a[j])];
            if (!i) break;
        }
        l = strlen(b+1);
        Rep(j,l,1) {
            u = back[u][int(b[j])];
            if (!u) break;
        }
        if (u==0 || i==0) {
            printf("-4\n");
        } else {
            int pos1 = back[n+1][int(a[m])];
            int pos2 = back[n+1][int(b[l])];
            if (pos1 < pos2) printf("-1\n");
            else if (pos1 > pos2) printf("-2\n");
            else printf("-3\n");
        }
    }
}


