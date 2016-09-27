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
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define N 100010

struct node {
    int val,pos;
};

int n,k,res;
node q[N];

bool cmp(node a,node b) {
    return a.val != b.val ? a.val < b.val : a.pos < b.pos;
}

int main() {
    //freopen("","r",stdin);
    //freopen("","w",stdout);
    scanf("%d%d",&n,&k);
    For(i,1,n) {
        int x;
        scanf("%d",&x);
        q[i].val = x; q[i].pos = i;
    }
    sort(q+1,q+n+1,cmp);
    int i = 1;
    while (i <= n) {
        int j = i;
        while (j < n && q[i].val == q[j+1].val) j++;
        int first = q[i].pos;
        For(t,i,j) if (q[t].pos - first + 1 > k) {
            res++;
            first = q[t].pos;
        }
        res++;
        i = j + 1;
    }
    cout << res;
}


