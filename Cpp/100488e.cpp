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
#define N 400010
using namespace std;

char s[N];
int dem[27];
int n,sum;

int main() {
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%s",s);
    n = strlen(s);
    For(i,0,n-1) dem[int(s[i])-int('a')]++;
   // For(i,0,n-1) cout << dem[i] << ' ';
    For(i,0,25) sum += dem[i];
   // printf("%d",sum);
    bool ok = true;
    For(i,0,25) if (dem[i]>sum-dem[i]) ok=false;
    if ((ok)&&(n%2==0)) printf("YES"); else printf("NO");
}

