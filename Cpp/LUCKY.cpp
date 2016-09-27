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
#define N 1000010
#define ll long long
const int a[] = {4,7,44,47,74,77,444};
using namespace std;
int ntest;
ll k;

void find() {
    For(i,0,5) {
        int sl=(int)((a[i]+1)/2);
        if ((ll)1<<sl<k) k-=(ll)1<<sl; else {
            k--;
            Ford(j,sl-1,0) if ((k>>j)&1) printf("%d",7); else printf("%d",4);
            if (a[i]%2==0) if (k&1) printf("%d",7); else printf("%d",4);
            For(j,1,sl-1) if ((k>>j)&1) printf("%d",7); else printf("%d",4);
            printf("\n");
            return;
        }
    }
    int sl=222;
    k--;
    Ford(j,sl-1,0) if ((k>>j)&1) printf("%d",7); else printf("%d",4);
    For(j,0,sl-1) if ((k>>j)&1) printf("%d",7); else printf("%d",4);
    printf("\n");
    return;
}

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%d\n",&ntest);
    while (ntest!=0) {
        ntest--;
        scanf("%d\n",&k);
        find();
    }
}

