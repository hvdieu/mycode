#include <iostream>
#include <cstdio>
#include <algorithm>
#define For(i,a,b) for(int i=a;i <= b; i++)
#define fi first
#define se second
using namespace std;
int n,pos[1000001],dir[1000001];
pair<int,int> g[1000001];
int main()
{
    freopen("input.inp","r",stdin);
    freopen("output.out","w",stdout);
    int n;
    scanf("%d",&n);
    For(i,1,n) scanf("%d%d",&g[i].fi,&g[i].se);
    sort(g+1,g+1+n);

}
