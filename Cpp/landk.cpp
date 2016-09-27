#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))
#define N 2001

int n,k,t[N],k2,h[N],l[N],r[N],p[N],top;
ll s[N][N];

ll sum (int i,int j,int u,int v) {
    return s[u][v] - s[u][j-1] - s[i-1][v] + s[i-1][j-1];
}

void inkq(int i,int j,int u,int v) {
    printf("%d %d %d %d",j,i,v,u);
}

int main() {
    freopen("landk.inp","r",stdin);
   // freopen("landk.out","w",stdout);
    scanf("%d%d",&k,&n);
    k2 = k * 2;
    For(i,1,n) {
        int x;
        For(j,1,n) {
            scanf("%d",&x);
            if (x >= k && x <= k2) {
                inkq(i,j,i,j); return 0;
            }
            s[i][j] = s[i-1][j] + s[i][j-1] - s[i-1][j-1] + x;
            if (s[i][j] >= k && s[i][j] <= k2) {
                inkq(1,1,i,j); return 0;
            }
            if (x > k2) {
                t[j] = i; h[j] = 0;
            } else {
                while (sum(t[j]+1,j,i,j) > 2*k) t[j]++;
                if (sum(t[j]+1,j,i,j) >= k) {
                    inkq(t[j]+1,j,i,j);
                    return 0;
                }
                h[j] = i - t[j];
            }
        }

        top = 1; l[1] = 1; p[1] = 1; p[0] = 0;
        For(j,2,n) {
            if (h[j] > h[j-1]) {
                l[j] = j; p[++top] = j;
            } else {
                while (top && h[j] <= h[p[top]]) top--;
                l[j] = p[top]+1; p[++top] = j;
            }
        }

        top = 1; r[n] = n; p[1] = n; p[0] = n + 1;
        Rep(j,n-1,1) {
            if (h[j] > h[j+1]) {
                r[j] = j; p[++top] = j;
            } else {
                while (top && h[j] <= h[p[top]]) top--;
                r[j] = p[top]-1; p[++top] = j;
            }
        }

        For(j,1,n) if (h[j] && sum(i - h[j] + 1,l[j],i,r[j]) >= k) {
            For(jj,l[j],r[j]) if (sum(i - h[j] + 1,l[j],i,jj) >= k) {
			    inkq(i - h[j] + 1,l[j],i,jj); return 0;
            }
        }
    }
    printf("NIE");
}


