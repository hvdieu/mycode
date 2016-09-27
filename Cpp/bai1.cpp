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
#define N 1000010

int m,n,d[N][26],f[N],cnt,id[N],k;
char s[N];

int main() {
    freopen("auto.in","r",stdin);
    freopen("auto.out","w",stdout);
    scanf("%d%d\n",&m,&n);
    For(i,1,m) {
        scanf("%s\n",(s+1));
        int len = strlen(s+1);
        int t = 0;
        For(j,1,len) {
            int ch = int(s[j]) - int('a');
            if (!d[t][ch]) {
                d[t][ch] = ++cnt; t = cnt;
                f[t]++;
            } else {
                t = d[t][ch]; f[t]++;
            }
        }
        id[t] = i;
    }
    while (n) {
        n--;
        scanf("%d %s\n",&k,(s+1));
        int t = 0;
        bool ok = true;
        int len = strlen(s+1);
        For(i,1,len) {
            int ch = int(s[i]) - int('a');
            if (d[t][ch] == 0) {
                ok = false; break;
            } else t = d[t][ch];
        }
        if (!ok || k > f[t]) printf("-1\n");
        else {
            while (1) {
                if (id[t]) k--;
                if (!k) {
                    printf("%d\n",id[t]);
                    break;
                }
                For(ch,0,25) if (f[d[t][ch]] >= k) {
                    t = d[t][ch];
                    break;
                } else k -= f[d[t][ch]];
            }
        }
    }
}
