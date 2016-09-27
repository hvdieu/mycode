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
#define N 11
#define M 1000000007

const int h[4] = {-1,0,1,0};
const int c[4] = {0,1,0,-1};
int n,a[4][N];
int f[3*N];
bool dd[362889];

vector<ii> step,next;
set<int> ff;
set<int>::iterator it;
bool found = false;
bool fr[31];
int sl;

int con() {
    int res = 0;
    memset(fr,true,sizeof(fr));
    For(i,1,3) For(j,1,n) {
    	int x = (i-1)*n + j;
        For(k,1,a[i][j]-1)
         if (fr[k])
		  res = (res + f[3*n-x]) % M;
        fr[a[i][j]] = false;
    }
    res = (res+1) % M;
    return res;
}

void inkq() {
    printf("%d\n",sz(step));
    For(i,0,sz(step)-1)
     printf("%d %d %d %d\n",step[i].fi,step[i].se,next[i].fi,next[i].se);
}

int dfs(int i, int j) {
    if (found) return 0;
	int t = con();
	if (t == 1) {
		inkq();
		found = true;
		return 0;
	}
	//ff.insert(t);
	dd[t] = true;
    For(k,0,3) {
        int u = i+h[k], v = j+c[k];
        if (u && v && u <= 3 && v <= n) {
            swap(a[i][j],a[u][v]);
            step.push_back(ii(i,j));
            next.push_back(ii(u,v));
            int t = con();
            //it = ff.find(t);
            //if (it == ff.end()) dfs(u,v);
            if (dd[t] == false) dfs(u,v);
            if (found) return 0;
            step.pop_back();
            next.pop_back();
            swap(a[i][j],a[u][v]);
        }
    }
    return 0;
}

int main() {
    freopen("bd.inp","r",stdin);
    freopen("bd.out","w",stdout);
    scanf("%d",&n);
    //cout << n;
    int vt,pi,pj;
    For(i,1,3)
     For(j,1,n) {
        cin >> a[i][j];
        if (a[i][j] == 1) {
            pi = i; pj = j;
        }
     }
    //For(i,1,3*n) cout << a[i] << ' ';
    f[0] = 1;
    f[1] = 1;
    For(i,2,3*n) {
        f[i] = (f[i-1]*i) % M;
    }
    memset(dd,false,sizeof(dd));
    dfs(pi,pj);
  //  cout << sz(ff);
}


