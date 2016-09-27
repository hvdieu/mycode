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

int m,q;
ll n;
char s[1000010];
int dem[26];
vector<int> vt[26];

int lower(int i,int key) {
    int d = 0, c = vt[i].size()-1, ans = -1;
    int mid;
    while (d <= c) {
        mid = (d+c)/2;
        if (vt[i][mid] >= key) {
            ans = mid;
            c = mid-1;
        } else d = mid+1;
    }
    return ans;
}

int upper(int i,int key) {
    int d = 0, c = vt[i].size()-1, ans = -1;
    int mid;
    while (d <= c) {
        mid = (d+c)/2;
        if (vt[i][mid] <= key) {
            ans = mid;
            d = mid+1;
        } else c = mid-1;
    }
   	return ans;
}

int main() {
   // freopen("piramida.inp","r",stdin);
    //freopen("piramida.out","w",stdout);
    cin >> n;
    cin >> (s+1);
    m = strlen(s+1);
    For(i,1,m) {
        vt[int(s[i]) - 65].pb(i);
        dem[int(s[i])-65]++;
    }
    cin >> q;
    For(i,1,q) {
        int x,c; char ch;
        cin >> x >> ch;
        c = int(ch) - int('A');
        ll sl,y;
        int t;
        if (x%2==0) t = (((x/2) % m) * ((x-1) % m)) % m;
        else t = (((x-1)/2 % m) * (x % m)) % m;
        if (t==0) t=m;
        t = m-t;
        int u = lower(c,m-t+1);
        int v = upper(c,min(m,m-t+x));
        ll res = 0;
        if (u!=-1 && v!=-1) res += v-u+1;
        sl = (x-t)/m;
        res += sl*dem[c];
        t = x-t-sl*m;
     	if (t != 0) {
     		u = lower(c,1);
     		v = upper(c,t);
     		if (u!=-1 && v!=-1) res += v-u+1;
     	}
        cout << res << "\n";
    }
}
