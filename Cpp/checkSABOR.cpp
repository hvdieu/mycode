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
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1 << x)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))
#define N 200010

int n, din[N];
char s[N];

int main() {
    freopen("SABOR.INP","r",stdin);
    freopen("checkSABOR.OUT","w",stdout);
    ifstream f1("output.out");
    f1 >> (s+1); f1.close();
    cin >> n;
    if (strlen(s+1) != n) {
        cout << "NO";
        return 0;
    }
    For(day, 1, 5) {
        int k, u, v;
        cin >> k;
        For(i, 1, k) {
            cin >> u >> v;
            if (s[u] == s[v]) {
                din[u]++; din[v]++;
            }
        }
    }
    bool flag = true;
    For(i, 1, n) if (din[i] > 2) flag = false;
    if (flag) cout << "YES";
    else cout << "NO";
}




