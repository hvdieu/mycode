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
using namespace std;

int n,res;
double a[N];
double T,low,high;

int check(int i,int t,double low, double high) {
    For(j,1,n) if (j!=i) {
        int cut = (int)ceil(a[j]/high)-1;
        if (a[j]/(cut+1)<low) return 1;
        t+=cut;
        if (t>=res) return 2;
    }
    res=t;
    return 1;
}

int main() {
    freopen("vegetables.in","r",stdin);
    freopen("vegetables.out","w",stdout);
    scanf("%lf %d\n",&T,&n);
    For(i,1,n) scanf("%lf",&a[i]);
    T+=0.0002; res = 500;
    For(i,1,n) {
        For(t,0,res) {
            high = a[i]/(t+1);
            low = high*T;
            if (check(i,t,low,high)==2) break;
        }
    }
    printf("%d",res);
}
