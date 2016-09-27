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
#define eps 0.001
int main() {
    //freopen("","r",stdin);
    freopen("checkMRAVI.OUT","w",stdout);
    ifstream f1("C:\output.out");
    ifstream f2("C:\anwser.out");
    double output, answer;
    f1 >> output;
    f2 >> answer;
    if (abs(answer - output) <= eps) cout << "YES";
    else cout << "NO";
    f1.close();
    f2.close();
}




