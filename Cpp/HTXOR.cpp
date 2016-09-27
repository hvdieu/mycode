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

int n,a[N],cnt,d[N*200][2],f[N*200];
ll m;
vector<int> b;
void push(int x) {
    int t = 0;
    Rep(i,19,0) {
        int bit = (x >> i) & 1;
        if (!d[t][bit]) {
            d[t][bit] = ++cnt; t = cnt;
            f[t]++;
        } else {
            t = d[t][bit]; f[t]++;
        }
    }
}

int get(int x,int i) {
    return (x >> i) & 1;
}

ll count(int x) {
    ll res = 0;
    For(i,1,n) {
        int t = 0;
        Rep(j,19,0) {
            int bit = get(x,j);
            int bit2 = get(a[i],j);
            if (bit) {
                res += f[d[t][bit2]];
                if (j) t = d[t][1-bit2];
                else res += f[t];
                if (t == 0) break;
            } else {
            	if (j) t = d[t][bit2];
                else res += f[t]; 
                if (t == 0) break;
            }
        }
    }
    return (res-n) / 2;
}

void trau() {
    For(i,1,n) For(j,i+1,n) b.pb(a[i] ^ a[j]);
    sort(b.begin(),b.end());
    cout << b[m-1] << "\n";
    For(i,0,sz(b)-1) cout << b[i] << ' ' ;
    cout << "\n";
}


void solve() {
    trau();
    For(i,1,n) push(a[i]);
    int d = 0, c = 18, mid,ans;
    while (d <= c) {
        mid = (d + c) / 2;
        ll x = count(mid);
        if (x >= m) {
            ans = mid;
            c = mid-1;
        } else d = mid+1;
    }
    cout << ans;
}

int main() {
    freopen("HTXOR.INP","r",stdin);
   // freopen("HTXOR.OUT","w",stdout);
    cin >> n >> m;
    For(i,1,n) scanf("%d",&a[i]);
    //trau();
    solve();
}
