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
#define reset(f,x) memset(f,x,sizeof(f))
#define N 1000001

struct node {
    ll val; int i, j;
    node(ll a, int b ,int c) {
        val = a; i = b; j = c;
    }
};

bool operator > (const node &a, const node &b) {
    return a.val > b.val;
}

int n, m, b[4][5000], dd[4][5000], sl[11];
ll a[11][N], temp[N];
ll k;
vector<ll> Q;
priority_queue<node, vector<node>, greater<node> > heap;

void sub1() {
    For(i1, 1, m) For(i2, 1, m) For(i3, 1, m) For(i4, 1, m) For(i5, 1, m) {
        ll x = 0;
        x += a[1][i1]; x += a[2][i2]; x += a[3][i3]; x += a[4][i4]; x += a[5][i5];
        Q.push_back(x);
    }
    sort(Q.begin(), Q.end());
    cout << Q[k - 1];
}

ll count(int x) {
    ll res = 0;
    int j = m;
    For(i, 1, m) if (a[1][i] > x) break; else {
        while (j && a[1][i] + a[2][j] > x) j--;
        res += j;
    }
    return res;
}

void sub2() {
    ll d = 0, c = a[1][m] + a[2][m], mid, ans;
    while (d <= c) {
        mid = (d + c) / 2;
        ll x = count(mid);
        if (x >= k) {
            ans = mid; c = mid - 1;
        } else d = mid + 1;
    }
    cout << ans;
}

int upper2(int d, int c, int key) {
    int mid, ans = 0;
    while (d <= c) {
        mid = (d + c) / 2;
        if (b[3][mid] <= key) {
            ans = mid; d = mid + 1;
        } else c = mid - 1;
    }
    return ans;
}

void sub3() {
    For(i, 1, 3) a[i][0] = -1;
    For(i, 1, 3) For(j, 1, m) {
        if (a[i][j] != a[i][j-1]) {
            b[i][++sl[i]] = a[i][j];
            if (i < 3) dd[i][sl[i]] = 1;
            else dd[i][sl[i]] = dd[i][sl[i] - 1] + 1;
        } else dd[i][sl[i]]++;
    }
    int d = 0, c = a[1][m] + a[2][m] + a[3][m], mid, ans;
    while (d <= c) {
        mid = (d + c) / 2;
        ll dem = 0;
        For (i1, 1, sl[1]) For(i2, 1, sl[2]) if (b[1][i1] + b[2][i2] > mid) break;
        else {
            int i3 = upper2(1, sl[3], mid - b[1][i1] - b[2][i2]);
            dem += ll(dd[3][i3]) * ll(dd[2][i2]) * ll(dd[1][i1]);
        }
        if (dem >= k) {
            ans = mid; c = mid - 1;
        } else d = mid + 1;
    }
    cout << ans;
}

void Do(int t1, int t2) {
    while (!heap.empty()) heap.pop();
    For(i, 1, 1) For(j, 1, sl[t2]) heap.push(node(a[t1][i] + a[t2][j], i, j));
    int cnt = 0;
    while (!heap.empty()) {
    	if (cnt == k) break;
        temp[++cnt] = heap.top().val; int i = heap.top().i, j = heap.top().j;
        heap.pop();
        if (i < sl[t1]) heap.push(node(a[t1][i+1] + a[t2][j], i+1, j));
    }
    For(i, 1, cnt) a[0][i] = temp[i];
    sl[0] = cnt;
}

void sub4() {
    For(i, 1, n) sl[i] = m;
    Do(1, 2);
    For(i, 3, n)
	  Do(0, i);
    cout << a[0][k];
}

int main() {
    freopen("VOSNSEQ.INP","r",stdin);
    freopen("VOSNSEQ.OUT","w",stdout);
    cin >> n >> m >> k;
    For(i, 1, n) {
        For(j, 1, m) scanf("%lld", &a[i][j]);
    }
    if (n == 5 && m <= 20) sub1();
    else if (n == 2 && m <= 1000000) sub2();
    else if (n == 3 && m <= 100000) sub3();
    else sub4();
}




