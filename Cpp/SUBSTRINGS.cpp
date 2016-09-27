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
const int N = 1 << 20;

int m,n,a[40],b[40];
int f[2*21][N];
ll res;

int get(int x,int i) {
    return (x >> i) & 1;
}

void duyet(int i,int j, int tt) {
    if (i + j == m) {
        int k = min(i,j);
        int x = i-j+m;
        f[x][tt >> k]++;
        return;
    }
    int k = i+j+1;
    if (i < j) {
        duyet(i,j+1,tt | (a[k] << j));
        if (((tt >> i) & 1) == a[k]) duyet(i+1,j,tt);
    } else if (i > j) {
        duyet(i+1,j,tt | (a[k] << i));
        if (((tt >> j) & 1) == a[k]) duyet(i,j+1,tt);
    } else {
        duyet(i+1,j,tt | (a[k] << i));
        duyet(i,j+1,tt | (a[k] << i));
    }
}

int tat(int x,int i) {
	return x & (~(1 << i));
}

void solve() {
    duyet(0,0,0);
    For(tt,0,(1 << n)-1) {
        int tt1 = 0, tt2 = 0, i = 0, j = 0;
        For(k,0,n-1) if ((tt >> k) & 1) {
            j++;
            tt2 |= (b[k+1] << (j-1));
        } else {
            i++;
            tt1 |= (b[k+1] << (i-1));
        }
        int x = j-i+m;
        bool ok = true;
        For(k,1,min(i,j)) if (get(tt1,i-k) != get(tt2,j-k)) {
            ok = false; break;
        }
        if (ok) {
            int tt3 = tt1 | tt2;
            For(t,max(i,j)-min(i,j),max(i,j)-1) {
                tt3 = tat(tt3,t);
            }
            res += f[x][tt3];
        }
    }
    cout << res;
}

int main() {
    freopen("substrings.inp","r",stdin);
  //  freopen("substrings.out","w",stdout);
    cin >> n;
    m = n/2; n = n - m;
    For(i,1,m) {
        char c; cin >> c;
        if (c == 'a') a[i] = 0; else a[i] = 1;
    }
    For(i,1,n) {
        char c; cin >> c;
        if (c == 'a') b[i] = 0; else b[i] = 1;
    }
    solve();
}
