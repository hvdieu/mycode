#include <bits/stdc++.h>

using namespace std;
typedef long long ll;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define all(x) x.begin(), x.end()
#define N 300010
#define C 100010

int n, c, m;
int a[N];
vector<int> color[C];

int random(int n) {
	return ((ll)rand() * rand()) % n;
}

int count(int x, int u, int v) {
	return upper_bound(all(color[x]), v) - upper_bound(all(color[x]), u-1);
}

int main() {
	srand(time(NULL));
	//freopen("input.txt", "r", stdin);
	scanf("%d%d", &n, &c);
	For(i, 1, n) {
		scanf("%d", &a[i]);
		color[a[i]].push_back(i);
	}
	scanf("%d", &m);
	For(i, 1, m) {
		int u, v; scanf("%d%d", &u, &v);
		int len = v - u + 1;
		bool ok = false;
		For(time, 1, 20) {
			int j = u + random(len);
			if (count(a[j], u, v) > len/2) {
				printf("yes %d\n", a[j]);
				ok = true; break;
			}
		}
		if (!ok) printf("no\n");
	}
}
