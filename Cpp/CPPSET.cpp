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
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())

set<int> s;
set<int>::iterator it;

int main() {
    freopen("CPPSET.INP","r",stdin);
    freopen("CPPSET.OUT","w",stdout);
    int kind,x;
    while (1) {
        scanf("%d",&kind);
        if (kind==0) break;
        if (kind<=2) {
            scanf("%d\n",&x);
            if (kind==1) s.insert(x);
             else s.erase(x);
        } else {
            if (kind>4) scanf("%d\n",&x);
               else scanf("\n");
            if (s.empty()) printf("empty\n");
             else {
                if (kind==3) printf("%d\n",*s.begin());
                else if (kind==4) {
                    it=s.end(); it--;
                    printf("%d\n",*it);
                }
                else {
                    if (kind==5) it=s.upper_bound(x);
                    if (kind==6) it=s.lower_bound(x);
                    if (kind==8) it=--s.upper_bound(x);
                    if (kind==7) it=--s.lower_bound(x);
                    if (it==s.end()) printf("no\n");
                     else printf("%d\n",*it);
                }
             }
        }
    }
}


