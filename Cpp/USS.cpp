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
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 500010

int n,a[N],res,b[N],bound[N];

void inkq() {
    For(i,1,n) printf("%d ",b[i]);
    printf("\n");
}

void up(int i) {
    b[i]++;
    if (b[i] == a[i]) b[i] = 0;
}

void solve() {
	while (1) {
    int i = n;
    while (i > 0 && bound[i]==b[i]) i--;
    if (i==0) return;
    up(i);
    For(j,i+1,n) {
        bound[j] = b[j]-1;
        if (bound[j] < 0) bound[j] = a[j]-1;
    }
    inkq();
	}
}

int main() {
    //freopen("USS.INP","r",stdin);
    freopen("USS.OUT","w",stdout);
    scanf("%d",&n);
    res = 1;
    For(i,1,n) {
        scanf("%d",&a[i]);
        res *= a[i];
    }
    cout << res-1 << "\n";
    For(i,1,n) bound[i] = a[i]-1;
    solve();
}



