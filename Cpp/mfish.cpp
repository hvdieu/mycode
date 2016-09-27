#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define N 100010

int n,s[N],m,f[N],pos[N],len[N],id[N],vt[N];

bool cmp(int i,int j) {
    return pos[i] < pos[j];
}

void solve() {
    For(i,1,m) id[i] = i;
    sort(id+1,id+1+m,cmp);
    pos[m+1] = n+1;
    id[m+1] = m+1;
    For(i,1,m) {
        For(j,pos[id[i]],pos[id[i+1]]-1) if (pos[id[i-1]] < j - len[i] + 1)
        vt[j] = id[i];
    }
    f[0] = 0;
    For(i,1,n) {
        f[i] = f[i-1];
        int j = vt[i];
        if (j && i - pos[j] + 1 <= len[j] && i >= len[j])
            f[i] = max(f[i],f[i - len[j]] + s[i] - s[i - len[j]]);
    }
    cout << f[n];
}

int main() {
   // freopen("mfish.inp","r",stdin);
   // freopen("mfish.out","w",stdout);
    scanf("%d",&n);
    For(i,1,n) {
        int x;
        scanf("%d",&x); s[i] = s[i-1] + x;
    }
    scanf("%d",&m);
    For(i,1,m) scanf("%d%d",&pos[i],&len[i]);
    solve();
}


