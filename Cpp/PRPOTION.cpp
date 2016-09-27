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

int ntest,R,G,B,M,mr,mg,mb,mm;

int main() {
    freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    cin >> ntest;
    while (ntest) {
        ntest--;
        mr = mg = mb = 0;
        cin >> R >> G >> B >> M;
        For(i,1,R) {
            int x; cin >> x; mr = max(mr,x);
        }
        For(i,1,G) {
            int x; cin >> x; mg = max(mg,x);
        }
        For(i,1,B) {
            int x; cin >> x; mb = max(mb,x);
        }
        while (M) {
            M--;
            mm = max(mb,max(mr,mg));
            if (mm==mr) mr = (mr)/2;
            else if (mm==mg) mg = (mg)/2;
            else mb = (mb)/2;
        }
        printf("%d\n",max(max(mr,mg),mb));
    }
}


