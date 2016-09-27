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

ll p,q,s,t;
ll temp,res;
int a[11000],sum[11000],b[11000];

void sub1() {
        temp = 1;
        res = 0;
        For(i,1,t) {
            p = p*10;
            if (i >= s) res = (res + p/q) % q;
            p %= q;
        }
        cout << res % q << "\n";
}

int mu(ll a, int b) {
    ll res = 1;
    while (b) {
        if (b & 1) res = (res*a) % q;
        a = (a*a) % q;
        b >>= 1;
    }
    return res;
}

void sub2() {
//	cout << mu(10,t-1) << "\n";
    p = (p*mu(10,t-1)) % q;
    p = (p*10)/q;
    cout << p << "\n";
}

void sub3() {
    memset(a,0,sizeof(a));
    memset(sum,0,sizeof(sum));
    int i = 0;
    int first,last,clength;
    while (1) {
        i++;
        p = p*10;
        if (!a[p]) {
            a[p] = i;
            b[i] = p/q;
            sum[i] = sum[i-1] + p/q;
            p %= q;
        } else {
            first = a[p]; last = i-1;
            clength = last-first+1;
            break;
        }
    }
    res = 0;
    if (t <= last) cout << (sum[t] - sum[s-1]) % q << "\n";
    else {
        int cnum = (t-first) / clength;
        if (s >= first) cnum -= (s-first)/clength;
        if (s > first && (s - first) % clength != 0) cnum--;
        res += (sum[last] - sum[first-1]) * cnum;
        res %= q;
        if (s >= first) {
        	s = (s-first+1) % clength;
            res += sum[last] - sum[s-1];
            res %= q;
        } else {
            res += sum[first-1] - sum[s-1];
            res %= q;
        }
        int u = t % first;
        t = (t-last) % clength;
       // while (u % last != 0) u--;
        res += sum[t+first-1] - sum[first-1];
        res %= q;
        cout << res << "\n";
    }
}

int main() {
    freopen("frac.inp","r",stdin);
    freopen("frac.out","w",stdout);
    int ntest;
    cin >> ntest;
    while (ntest) {
        ntest--;
        cin >> p >> q >> s >> t;
        p %= q;
        if (t <= 100) sub1();
        else if (s==t) sub2();
        else sub3();
    }
}



