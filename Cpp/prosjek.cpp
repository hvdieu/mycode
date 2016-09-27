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
#define N 110
ll a[N],b[N];
int n;

int main() {
   // freopen("","r",stdin);
   // freopen("","w",stdout);
    cin >> n;
    For(i,1,n) cin >> b[i];
    a[1] = b[1];
    int s = 0;
    For(i,2,n) {
        s += a[i-1];
        a[i] = b[i]*i-s;
    }
    For(i,1,n) cout << a[i] << ' ';
}



