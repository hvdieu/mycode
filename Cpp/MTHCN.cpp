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
#define N 1010
int a[N][N],b[N][N];
using namespace std;

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d %d",&m,&n);
    int i,u,v,k;
    while (m) {
        m--;
        scanf("%d%d%d",&i,&u,&v,&k);
        a[i][u]+=k; a[i][v+1]-=k;
    }
}

