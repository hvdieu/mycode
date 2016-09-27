#include <bits/stdc++.h>

using namespace std;

typedef long long ll;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b; i++)
#define REP(i, n) for(int i = 0; i < n; i++)
#define sz(x) int(x.size())
#define reset(f, x) memset(f, x, sizeof(f));
#define N 101
#define BASE 1000000007

int n, a[N], t[N], id[N];
ll c[N][N], f[N][N];
vector<int> b;

void update(int i, int x) {
	for(i; i <= n; i += i & (-i)) t[i] += x;
}

int get(int i) {
	int s = 0;
	for(; i; i -= i & (-i)) s += t[i];
	return s;
}

void add(ll &a, ll b) {
	a = (a + b) % BASE;
}

int main() {
	freopen("input.txt", "r", stdin);
	scanf("%d", &n);
	For(i, 1, n) scanf("%d", a+i);
	For(i, 0, n) c[0][i] = 1;
	For(j, 1, n) For(i, 1, j)
	c[i][j] = (c[i][j-1] + c[i-1][j-1]) % BASE;
	For(i, 1, n) f[i][i] = 1;
	for(int len = 1; len < n; len++) for(int i = 1; i <= n-len; i++) {
		int j = i + len;
		b.clear(); reset(t, 0);
		For(k, i, j) b.push_back(a[k]);	
		sort(b.begin(), b.end());
		for(int k = 0; k < sz(b); k++) id[b[k]] = k+1;
		for(int k = i; k < j; k++) {
			update(id[a[k+1]], 1);
			if (get(k-i+1) == k-i+1)
			add(f[i][j], (((f[i][k] * f[k+1][j]) % BASE) * c[k-i][j-i-1]) % BASE);
			update(id[a[k+1]], -1);
			update(id[a[k]], 1);
		}
	}
	cout << f[3][4] << endl;
	cout << f[1][n];
}
