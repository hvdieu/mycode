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
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 110
#define BASE 2014

int n,f[N][N];
unsigned long long h[N],mu[N];
char s[N];
bool check[N][N];

ull get(int i,int j) {
    return h[j] - h[i-1] * mu[j-i+1];
}

bool cmp(int i,int j,int u,int v) {
    ull x = get(i,j), y = get(u,v);
    return x == y;
}

int cal(int i,int j) {
    if (check[i][j]) return f[i][j];
    f[i][j] = 1;
    int n = j-i+1;
    int bound;
    if (n % 2 ==0) bound = n/2-1;
    else bound = n/2;
    if (i < j) {
        For(k,1,bound) {
            if (cmp(i,i+k-1,i+k,i+k+k-1)) f[i][j] = (f[i][j] + cal(i+k,j)) % BASE;
            if (cmp(i,i+k-1,j-k+1,j)) f[i][j] = (f[i][j] + cal(i+k,j) + cal(i,j-k)) % BASE;
            if (cmp(j-k+1,j,j-k-k+1,j-k)) f[i][j] = (f[i][j] + cal(i,j-k)) % BASE;
        }
    }
    check[i][j] = true;
    return f[i][j];
}

int main() {
    freopen("bai3.inp","r",stdin);
    freopen("bai3.out","w",stdout);
    scanf("%s",(s+1));
    int n = strlen(s+1);
    mu[0] = 1;
    For(i,1,n) mu[i] = mu[i-1]*26;
    For(i,1,n) {
        int ch = int(s[i]) - int('A');
        h[i] = h[i-1] * 26 + ch;
    }
    //cal(2,5);
    printf("%d",cal(1,n)-1);
}
