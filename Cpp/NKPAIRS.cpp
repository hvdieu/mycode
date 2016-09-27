#include <bits/stdc++.h>

using namespace std;

typedef pair<int, int> ii;
typedef long long ll;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define Rep(i, a, b) for(int i = a; i >= b, i++)
#define x first
#define y second
#define N 100010

int kind, n, m, D;
int a[100001];
ii b[N];
long long res = 0;


void sub1() {
	For(i, 1, n) scanf("%d", a+i);
	sort(a+1, a+n+1);
	int j = 1;
	For(i, 1, n) {
		while (a[i] - a[j] > D) j++;
		res += i-j;
	}
	cout << res;
}

const int M = 75000;
int t[2*N + 10];

void update(int i, int x) {
	for(i; i <= 2*m; i += i & (-i)) t[i] += x;
}

int get(int i) {
	int s = 0;
	for (i; i; i -= i & (-i)) s += t[i];
	return s;
}

void sub2() {
	For(i, 1, n) {
		int x, y;
		scanf("%d%d", &x, &y);
		b[i] = ii(x+y, x-y);
	}
	sort(b+1, b+n+1);
	int j = 1;
	For(i, 1, n) {
		while (b[i].x - b[j].x > D) update(b[j++].y + m, -1);
		int u = max(1, b[i].y-D+m), v = min(2*m, b[i].y+D+m);
		res +=  get(v) - get(u-1);
		update(b[i].y+m, 1);
	}
	cout << res;
}

int s[76][226][151], d[76][76][76];

int sum(int k, int i, int j, int u, int v) {
	return s[k][u][v] - s[k][i-1][v] - s[k][u][j-1] + s[k][i-1][j-1];
}

void sub3() {
	For(i, 1, n) {
		int x, y, z;
		scanf("%d%d%d", &x, &y, &z);
		d[x][y][z]++;
		s[x][y+z+m][y-z+m]++;
	}
	For(x, 1, m) For(i, 1, 3*m) For(j, 1, 2*m)
	s[x][i][j] += s[x][i][j-1] + s[x][i-1][j] - s[x][i-1][j-1];
	ll MAX = 0;
	For(x, 1, m) For(y, 1, m) For(z, 1, m)
	if (d[x][y][z]) For(xx, max(1, x-D), min(m, x+D)) {
		int len = D-abs(x-xx);
		int x1 = max(1, y+z-len+m), y1 = max(1, y-z-len+m);
		int x2 = min(3*m, y+z+len+m), y2 = min(2*m, y-z+len+m);
		//printf("%d %d %d %d %d\n", x, y, z, xx, sum(xx, x1, y1, x2, y2));
		//printf("%d %d %d %d\n", x1, y1, x2, y2);
		res += ll(d[x][y][z])*sum(xx, x1, y1, x2, y2);
		MAX = max(MAX, res);
		if (xx == x) res -= d[x][y][z];
	}
	//cout << MAX << endl;
	cout << res / 2;
}

int main() {
   // freopen("input.txt", "r", stdin);
	scanf("%d%d%d%d", &kind, &n, &D, &m);
	if (kind == 1) sub1();
	else if (kind == 2) sub2();
	else sub3();
}
