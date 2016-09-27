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
#define N 110

int m,n,col[N][N],d,res;
char s[N][N];
bool d1[N],d2[N];

void init() {
    res = d;
    while (res) {
    	bool ok = false;
        For(i,1,m) {
        For(j,1,n) if (s[i][j] == '1' && !col[i][j]) {
            col[i][j] = res; ok = true;
            break;
        }
        	if (ok) break;
    	}
        res--;
    }
}

void solve() {
    For(i,1,m)
        For(j,1,n) if (s[i][j] == '1' && !col[i][j]) {
            int u,v;
            memset(d1,true,sizeof(d1));
            For(k,1,n) if (col[i][k]) d1[col[i][k]] = false;
            memset(d2,true,sizeof(d2));
            For(k,1,m) if (col[k][j]) d2[col[k][j]] = false;
            u = 0; v = 0;
            For(k,1,d) if (d1[k] && d2[k]) {
                u = k; v = k; break;
            }
            if (!u) {
                For(k,1,d) if (d1[k]) u = k;
                For(k,1,d) if (d2[k]) v = k;
            }
            if (u == v) col[i][j] = u;
            else {
                col[i][j] = u;
                int ii = i, jj = j, mau = v;
                while (1) {
                    bool stop = true;
                    For(k,1,n) if (k != jj && col[ii][k] == col[ii][jj]) {
                        stop = false;
                        col[ii][k] = mau;
                        if (mau == u) mau = v;
                        else mau = u;
                        jj = k;
                        break;
                    }
                    For(k,1,m) if (k != ii && col[k][jj] == col[ii][jj]) {
                        stop = false;
                        col[k][jj] = mau;
                        if (mau == u) mau = v;
                        else mau = u;
                        ii = k;
                        break;
                    }
                    if (stop) break;
                }
            }
        }
}

int main() {
    freopen("nkdec.inp","r",stdin);
    //freopen("nkdec.out","w",stdout);
    scanf("%d%d",&m,&n);
    For(i,1,m) scanf("%s\n",(s[i]+1));
    For(i,1,m) {
        int dem = 0;
        For(j,1,n) if (s[i][j] == '1') dem++;
        d = max(d,dem);
    }
    For(j,1,n) {
        int dem = 0;
        For(i,1,m) if (s[i][j] == '1') dem++;
        d = max(d,dem);
    }
    printf("%d\n",d);
    init();
    solve();
    For(i,1,m) {
        For(j,1,n) printf("%d ",col[i][j]);
        printf("\n");
    }
}
