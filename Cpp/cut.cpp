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
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())

unsigned long long a,b,c,d;

int main() {
    freopen("cut.inp","r",stdin);
    freopen("cut.out","w",stdout);
    int ntest;
    cin >> ntest;
    while (ntest) {
        ntest--;
        cin >> a >> b >> c >> d;
        if (a > b) swap(a,b);
        if (a > c) swap(a,c);
        if (b > c) swap(b,c);
        if ((c-b) <= d) {
            d -= (c-b);
            c = b;
        } else {
            c -= d;
            d = 0;
        }
        if (d && (b-a)*2 <= d) {
            d -= (b-a)*2;
            b = a; c = a;
        } else if (d) {
            ull x = d/2;
            c -= x;
            b -= (d-x);
            d = 0;
        }
        if (d) {
            ull x = d/3;
            if (d%3 == 2) x++;
            a -= x;
            b -= x ;
            c -= (d-x*2);
        }
        cout << a*b*c << "\n";
    }
}



