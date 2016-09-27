#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define N 510
#define oo 3210121
using namespace std;

char s1[N],s2[N];
int m,n,g[N][N][N];
bool check[N][N][N];
bool p1[N][N],p2[N][N];

int tinh(int i, int j, int u,int v) {
    if (check[i][j][u]) return g[i][j][u];
    int res=0;
    if ((i>j)&&(u>v)) return 1;
    if ((i==j)&&(u==v)) {
        if (s1[i]==s2[u]) return 2;
        return 0;
    }
    if (i>j) {
        if (p2[u][v]) return 1;
         else return 0;
    }
    if (u>v) {
        if (p1[i][j]) return 1;
         else return 0;
    }
    if (i==j) {
    	if (u>v) return 1;
        if (s1[i]==s2[v]) res += tinh(i+1,j-1,u,v-1);
        if (s1[i]==s2[u]) res += tinh(i+1,j-1,u+1,v);
        if (s2[u]==s2[v]) res += tinh(i,j,u+1,v-1);
        if (res>=oo) res %= oo;
        check[i][j][u]=true;
        g[i][j][u]=res;
        return res;
    }
    if (u==v) {
    	if (i>j) return 1;
        if (s1[i]==s2[v]) res += tinh(i+1,j,u+1,v-1);
        if (s1[j]==s2[v]) res += tinh(i,j-1,u+1,v-1);
        if (s1[i]==s1[j]) res += tinh(i+1,j-1,u,v);
        if (res>=oo) res %= oo;
        check[i][j][u]=true;
        g[i][j][u]=res;
        return res;
    }
    if ((i<j)&&(s1[i]==s1[j])) res += tinh(i+1,j-1,u,v);
    if ((u<v)&&(s2[u]==s2[v])) res += tinh(i,j,u+1,v-1);
    if ((i<j)&&(u<v)) {
        if (s1[i]==s2[v]) res += tinh(i+1,j,u,v-1);
        if (s2[u]==s1[j]) res += tinh(i,j-1,u+1,v);
    }
    if (res>=oo) res %= oo;
    check[i][j][u]=true;
    g[i][j][u]=res;
    return res;
}

int main() {
    //freopen("palin.inp","r",stdin);
    //freopen("palin.out","w",stdout);
    scanf("%s\n",s1);
    scanf("%s",s2);
    m=strlen(s1); n=strlen(s2);
    For(i,0,m-1) {
        p1[i][i]=true;
        int u=i-1,v=i+1;
        while ((u>=0)&&(v<=m-1)&&(s1[u]==s1[v])) {
            p1[u][v]=true; u--; v++;
        }
        u=i; v=i+1;
        while ((u>=0)&&(v<=m-1)&&(s1[u]==s1[v])) {
            p1[u][v]=true; u--; v++;
        }
    }
    For(i,0,n-1) {
        p2[i][i]=true;
        int u=i-1,v=i+1;
        while ((u>=0)&&(v<=n-1)&&(s2[u]==s2[v])) {
            p2[u][v]=true; u--; v++;
        }
        u=i; v=i+1;
        while ((u>=0)&&(v<=n-1)&&(s2[u]==s2[v])) {
            p2[u][v]=true; u--; v++;
        }
    }
    printf("%d",tinh(0,m-1,0,n-1));
}



