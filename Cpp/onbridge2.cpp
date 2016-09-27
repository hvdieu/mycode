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

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ll long long
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define N 50010

const int MAXN = 50010;

int n, bridges, par[MAXN], bl[MAXN], comp[MAXN], size[MAXN],ntest,m;

void init() {
	for (int i=0; i<n; ++i) {
		bl[i] = comp[i] = i;
		size[i] = 1;
		par[i] = -1;
	}
	bridges = 0;
}


int get (int v) {
	if (v==-1)  return -1;
	return bl[v]==v ? v : bl[v]=get(bl[v]);
}

int get_comp (int v) {
	v = get(v);
	return comp[v]==v ? v : comp[v]=get_comp(comp[v]);
}

void make_root (int v) {
	v = get(v);
	int root = v,
		child = -1;
	while (v != -1) {
		int p = get(par[v]);
		par[v] = child;
		comp[v] = root;
		child=v;  v=p;
	}
	size[root] = size[child];
}


int cu, u[MAXN];

void merge_path (int a, int b) {
	++cu;

	vector<int> va, vb;
	int lca = -1;
	for(;;) {
		if (a != -1) {
			a = get(a);
			va.pb (a);

			if (u[a] == cu) {
				lca = a;
				break;
			}
			u[a] = cu;

			a = par[a];
		}

		if (b != -1) {
			b = get(b);
			vb.pb (b);

			if (u[b] == cu) {
				lca = b;
				break;
			}
			u[b] = cu;

			b = par[b];
		}
	}

	for (size_t i=0; i<va.size(); ++i) {
		bl[va[i]] = lca;
		if (va[i] == lca)  break;
		--bridges;
	}
	for (size_t i=0; i<vb.size(); ++i) {
		bl[vb[i]] = lca;
		if (vb[i] == lca)  break;
		--bridges;
	}
}


void add_edge (int a, int b) {
	a = get(a);   b = get(b);
	if (a == b)  return;

	int ca = get_comp(a),
		cb = get_comp(b);
	if (ca != cb) {
		++bridges;
		if (size[ca] > size[cb]) {
			swap (a, b);
			swap (ca, cb);
		}
		make_root (a);
		par[a] = comp[a] = b;
		size[cb] += size[a];
	}
	else
		merge_path (a, b);
}
int main() {
    freopen("ONBRIDGE.INP","r",stdin);
    freopen("ONBRIDGE.OUT","w",stdout);
    scanf("%d",&ntest);
    while (ntest) {
        ntest--;
        scanf("%d%d",&n,&m);
        init();
        For(i,1,m) {
            int u,v;
            scanf("%d%d",&u,&v);
            u++; v++;
            add_edge(u,v);
            printf("%d\n",bridges);
        }
    }
}


