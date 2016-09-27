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
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second

#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 300010
#define NN 33554432
#define M 10000007

int n;
int dem[60];
int cnt[NN],cc[M];
char s[N];
ll res;
map<ll,int> ff;
map<ll,int>::iterator it;

void solve() {
    cnt[0]++;
    ll tt=0,t1;
    For(i,1,n) {
        int ch = int(s[i])-int('A');
        if (ch>25) ch = int(s[i])-int('a')+26;
        dem[ch] = (dem[ch]+1) % 2;
        if (dem[ch]) tt |= ll(1) << ch;
            else tt &= (~(ll(1) << ch));
        t1 = 0;
        if (tt < NN) res += cnt[tt];
            else {
                it = ff.find(tt);
                if (it!=ff.end()) res += it->second;
            }
        For(j,0,51) if (j!=ch) {
            if (dem[j]) t1 = tt & (~(ll(1) << j));
                else t1 = tt | (ll(1) << j);
            if (t1 < NN) res += cnt[t1];
                else {
                    it = ff.find(t1);
                    if (it!=ff.end()) res += it->second;
                }
        } else {
        	if (dem[j]) t1 = tt & (~(ll(1) << j));
                else t1 = tt | (ll(1) << j);
            int X;
            if (t1 < NN) X = cnt[t1];
                else {
                    it = ff.find(t1);
                    if (it!=ff.end()) X = it->second;
                        else X = 0;
                }
            if (X>0) res+=(X-1);
        }
        if (tt < NN) cnt[tt]++;
            else ff[tt]++;
    }
    cout << res+n;
}

int main() {
    freopen("CVPDROME.INP","r",stdin);
    freopen("CVPDROME.OUT","w",stdout);
    cin >> n;
    cin >> (s+1);
    solve();
}


