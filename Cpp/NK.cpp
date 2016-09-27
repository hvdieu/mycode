#include <vector>
#include <algorithm>
#include <math.h>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstring>
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
#define ld long double
#define pb push_back
#define all(x) x.begin(), x.end()
#define reset(f,x) memset(f,x,sizeof(f))
#define sz(s) int(s.size())
#define two(i) (ll(1) << i)
#define bit(x, i) ( (x >> i) & 1 )
#define onbit(x, i) ( x | (1 << i ) )
#define N 200
#define inf 1000000

int n, m, d[N][N];
char trace[N][N];
string a, b;
queue<ii> q;
bool was[N][N];

void truyvet(int i, int j) {
    vector<char> kq;
    while (1) {
        if (trace[i][j] == '1') break;
        kq.pb(trace[i][j]);
        char ch = trace[i][j];
        if (ch == 'P') j--;
        else if (ch == 'S') j--;
        else if (ch == 'L') i++;
        else if (ch == 'R') i--;
        if (i < 0) i = n-1;
        else if (i == n) i = 0;
    }
    reverse(all(kq));
    For(i, 0, sz(kq)-1) cout << kq[i];
}

void solve() {
    For(i, 0, n) For(j, 0, m) d[i][j] = inf;
    d[0][0] = 0; was[0][0] = true;
    trace[0][0] = '1';
    q.push(ii(0, 0));
    while (!q.empty()) {
        int i = q.front().fi, j = q.front().se;
        q.pop();
        if (j == m) {
            truyvet(i, j);
            return;
        }
        if (b[j] == ' ') {
            if (d[i][j+1] > d[i][j] + 1) {
                d[i][j+1] = d[i][j] + 1;
                trace[i][j+1] = 'S';
                if (!was[i][j+1]) {
                    was[i][j+1] = true;
                    q.push(ii(i, j+1));
                }
            }
        } else {
            if (a[i] == b[j]) {
                if (d[i][j+1] > d[i][j] + 1) {
                    d[i][j+1] = d[i][j] + 1;
                    trace[i][j+1] = 'P';
                    if (!was[i][j+1]) {
                        was[i][j+1] = true;
                        q.push(ii(i, j+1));
                    }
                }
            }
            for(int k = -1; k <= 1; k += 2) {
                int u = i + k;
                if (u < 0) u = n - 1;
                else if (u == n) u = 0;
                if (d[u][j] > d[i][j] + 1) {
                    d[u][j] = d[i][j] + 1;
                    trace[u][j] = 'L'; if (k > 0) trace[u][j] = 'R';
                    if (!was[u][j]) {
                        was[u][j] = true;
                        q.push(ii(u, j));
                    }
                }
            }
        }
    }
}

int main() {
    freopen("NK.INP","r",stdin);
    freopen("NK.OUT","w",stdout);
    getline(cin, a); getline(cin, b);
    n = sz(a); m = sz(b);
    solve();
}
