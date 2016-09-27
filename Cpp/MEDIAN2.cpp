#include <iostream>
#include <cstring>
#include <stdio.h>
using namespace std;

const int MAX = 65536;

int seed, mul, ad, n, k;

int R[MAX];
int S[MAX*3];

void add( int n, int l, int r, int i, int v) {
	S[n] += v;
	if(l<r) {
		int m = (l+r) / 2;
		if(i<=m) add( 2*n, l, m, i, v);
		else add( 2*n+1, m+1, r, i, v);
	}
}

int get( int n, int l, int r, int k) {
	if(l==r) return l;
	int m = (l+r)/2;
	if(S[2*n]>=k) return get( 2*n, l, m, k);
	else return get( 2*n+1, m+1, r, k - S[2*n]);
}


int main() {
	int st, t;
	freopen("MEDIAN.INP","r",stdin);
	freopen("MEDIAN.OU1","w",stdout);
	scanf("%d", &st);
	for(t=1;t<=st;++t) {
		scanf("%d%d%d%d%d", &seed, &mul, &ad, &n, &k);
		memset( R, -1, sizeof(R));
		memset( S, 0, sizeof(S));
		long long begin = seed, end;
		for(int i=0;i<k;++i) {
			add( 1, 0, MAX-1, begin, 1);
			begin = (begin * mul % MAX + ad) % MAX;
		}
		end = begin;
		begin = seed;
		long long total = 0;
		for(int i=0;i<=n-k;++i) {
			if(R[begin]!=-1) {
				total += R[begin];
			}
			else {
				int tmp = get( 1, 0, MAX-1, (k+1)/2 );
				R[begin] = tmp;
				total += tmp;
				add( 1, 0, MAX-1, begin, -1);
				add( 1, 0, MAX-1, end, 1);
			}
			begin = (begin * mul % MAX + ad) % MAX;
			end = (end * mul % MAX + ad) % MAX;
		}
		printf("Case #%d: %lld\n", t, total);
	}
	return 0;
}

