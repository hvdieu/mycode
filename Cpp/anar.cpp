//* Problem  : ANARC-2009
//* Date     : 2010.02.15
//* Author   : alt
//* Tags     :

#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <iostream>
#include <numeric>
#include <sstream>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <memory>
#include <string>
#include <vector>
#include <cctype>
#include <list>
#include <queue>
#include <deque>
#include <stack>
#include <map>
#include <set>
#include <algorithm>

using namespace std;

//stack
//#pragma comment(linker, "/STACK:16777216")

// to disable Visual C++ secure warnings
#pragma warning(disable : 4996)

///BEGIN CUT HERE
// types
typedef long long int64;
typedef unsigned long long uint64;
typedef pair <int,int> PII;
typedef vector <int> VI;
typedef vector <int64> VI64;
typedef vector <string> VS;
typedef vector <vector<string> > VVS;
typedef vector <vector<int> > VVI;
typedef vector <pair<int,int> > VPII;
typedef vector <vector<pair<int,int> > > VVPII;
typedef map<int, int > MII;
typedef map<string, int > MSI;
typedef queue<int > QI;
typedef queue<PII > QPII;
//loops
#define FOR(i, n) for (int i = 0; i < (int)(n); i++)
#define FORR(i, n) for (int i = (int)(n)-1; i >= 0; i--)
#define FORE(i, a, b) for (int i = (int)(a); i <= (int)(b); i++)
#define FORER(i, a, b) for (int i = (int)(a); i >= (int)(b); i--)
#define FORSZ(i, a) FOR(i, SZ(a))
#define FORSZR(i, a) FORR(SZ(a), i)
#define FORO(i, x) for (typeof((x).begin()) i = (x).begin(); i != (x).end(); i++)
#define FOROR(i, x) for (typeof((x).end()) i = (x).end(); i != (x).begin(); i--)
#define REP(n) for (int _foo = (int)(n) - 1; _foo >= 0; _foo--)
#define REP2(n) for (int _foo2 = (int)(n) - 1; _foo2 >= 0; _foo2--)

#define VAR(a, b) typeof(b) a=(b)
#define FOREACH(it, c) for(VAR(it,(c).begin()); it!=(c).end(); it++)
//sorting & c
#define ALL(a) a.begin(), a.end()
#define RALL(a) a.rbegin(), a.rend()
#define SORT(a) sort(ALL(a))
#define RSORT(a) sort(RALL(a))
#define UNIQUE(c) SORT(c),(c).resize(unique(ALL(c))-(c).begin())
#define REVERSE(a) reverse(ALL(a))
//filling
#define FLA(a,val) memset(a, val, sizeof(a))
#define FLO(o,val) memset(&o, val, sizeof(o))
#define CLA(a) FLA(a, 0)
#define CLO(a) FLO(a, 0)
//misc
#define _x first
#define _y second
#define MP make_pair
#define PB push_back
#define SZ(a) (int)a.size()
#define POP(a) a.top(), a.pop()
#define FRONT(a) a.front(), a.pop()
//const
const int INF = 1000000000;
const int64 INFL = 1000000000000000000LL;
const double PI = acos(-1.0);
const double EPS = 1E-9;

const int dx4[] = {-1, 1, 0, 0};
const int dy4[] = {0, 0, -1, 1};
const int dx8[] = {-1, 1, 0, 0, -1, -1,  1, 1};
const int dy8[] = {0, 0, -1, 1, -1,   1, -1, 1};

//some math
template <typename T> inline T gcd(T a, T b)				{ return b ? gcd(b, a % b) : a; }
template <typename T> inline T gcd2(T a, T b)				{ while (a && b) (a > b) ? a %= b : b %= a; return a + b;}
template <typename T> inline T lcm(T a, T b)				{ return a / gcd(a, b) * b; }
template <typename T> inline T abs(T a)					{ return a < 0 ? -a : a; }
template <typename T> inline T sqr(T a)					{ return a * a; }
template <typename T> inline double hypot(T a, T b)		{ return sqrt(1.0 * a * a + b * b);}
//template <typename T> inline double hypot(T a, T b, T ñ)	{ return sqrt(1.0 * a * a + b * b + ñ * ñ);}
template <typename T> inline T hypot2(T a, T b)			{ return a * a + b * b;}
//template <typename T> inline T hypot2(T a, T b, T c)		{ return a * a + b * b + c * c;}
template <typename T> inline void chMin(T& a, T b) { if (b < a) a = b; }
template <typename T> inline void chMax(T& a, T b) { if (b > a) a = b; }

//assertions
#ifdef _DEBUG
#define ASSERT(f) if (!(f)) printf("%s\n", "ASSERTION FAILED!");
#define ASSERTS(f, s) if (!(f)) printf("%s [%s]\n", "ASSERTION FAILED!", s);
#else
#define ASSERT(f) f
#define ASSERTS(f, s) f
#endif

int cmp_int(const void *a, const void *b){return *(int*)a - *(int*)b;}
int cmp_double(const void *a, const void *b){double t = *(double*)a - *(double*)b;return (fabs(t) < EPS) ? 0 : t > 0 ? 1 : -1;}
int cmp_int64(const void *a, const void *b){int64 t = *(int64*)a - *(int64*)b; return !t ? 0 : t > 0 ? 1 : -1;}

//input
inline void ri(int &tt){ASSERTS(scanf("%d", &tt) == 1, "ReadInt failed");}
inline int ri(){int tt; ASSERTS(scanf("%d", &tt) == 1, "ReadInt failed"); return tt;}
inline void ri64(int64 &tt){ASSERTS(scanf("%lld", &tt) == 1, "ReadInt64 failed");}
inline int64 ri64(){int64 tt; ASSERTS(scanf("%lld", &tt) == 1, "ReadInt64 failed"); return tt;}
inline void rd(double &tt){ASSERTS(scanf("%lf", &tt) == 1, "ReadDouble failed"); }
inline double rd(){double tt; ASSERTS(scanf("%lf", &tt) == 1, "ReadDouble failed"); return tt;}
inline void rs(char *s){ASSERTS(scanf("%s", s) == 1, "ReadChar* failed");}
//output
inline void pvi(int *a, int n){FOR(i, n) printf("%d%c", a[i], i == n - 1 ? '\n' : ' ');}
inline void pvi(VI a){FORSZ(i,a) printf("%d%c", a[i], i == a.size() - 1 ? '\n' : ' ');}
inline void pi(int n){printf("%d\n", n);}
inline void pi64(int64 n){printf("%lld\n", n);}

inline void _pi64(int64 n)
{
	if (n < 0) {putchar('-'); n = -n;}
	if (!n) {putchar('0'); return;}
	char stack[30]; int istack = 0;
	while (n)
	{
		stack[istack++] = (n % 10) + '0'; n /= 10;
	}
	while (istack > 0)
		putchar(stack[--istack]);
}

///END CUT HERE

int N, res, M, n, k;

int y[10][10];

int r[10][10];

int coef[10][10][10][10], ccoef[10][10];

vector<vector<double > > A;

template <typename T> T normalize(T val, T p)
{
	val %= p;
	while (val < 0) val += p;
	return val;
}



template <typename T> T gcd_extended(T a, T b, T &x, T &y)
{
	if (a == 0)
	{
		x = 0; y = 1;
		return b;
	}
	T x1, y1;
	T d = gcd_extended(b % a, a, x1, y1);
	x = y1 - (b / a) * x1;
	y = x1;
	return d;
}




template <typename T> T inverse(T a, T p)
{
	T x, y, d;
	d = gcd_extended(p, a, x, y);
	if (d != 1)
		return 0;
	return normalize(y, p);
}

#define MOD 100000000009LL

void solve()
{
	CLA(coef);
	CLA(ccoef);
	int c = 0;
	int sz = n = N * M;
	A.assign(sz, vector<double>(sz+1));
	FOR(i,N) FOR(j,M)
	{
		int cc = 0;
		FOR(ii, N) FOR(jj, M)
		{
			if (abs(i-ii) + abs(j-jj) <= k)
			{
				coef[i][j][ii][jj] = 1;
				ccoef[i][j]++;
				A[c][cc] = 1;
			}
		//	printf("%d ", A[c][cc]);
			cc++;
		}
		A[c++][n] = y[i][j] * ccoef[i][j];
	//	printf(" = %d\n", A[c-1][n]);
	}
	//
	for (int i = 0; i < n; i++)
	{
		int k = i;
		for (int j = i + 1; j < n; j++)
			if (fabs(A[j][i]) > fabs(A[k][i]) && A[k][i] > EPS)
				k = j;
		swap (A[i], A[k]);
		for (int j = i + 1; j <= n; j++)
		{
			A[i][j] /= A[i][i];
		}
		for (int j=0; j<n; ++j)
			if (j != i)
				for (int k=i+1; k<=n; ++k)
				{
					A[j][k] -= A[i][k] * 1LL * A[j][i];
				}
	}
	for (int i = 0; i < n; ++i)
		r[i/M][i%M] = A[i][n] + EPS;
}


int main()
{
#ifdef _DEBUG
	freopen("input", "r", stdin);
	freopen("1064o", "w", stdout);
#endif
    freopen("input.txt","r", stdin);
    freopen("output.txt","w",stdout);
	int nt = 0;
	while (1)
	{
		N = ri();
		if (!N)
			break;
		M = ri();
		k = ri();
		FOR(i,N) FOR(j,M) y[i][j] = rd() * 100 + EPS;
		solve();
		if (nt++) putchar('\n');
		FOR(i,N) FOR(j,M)
		{
			printf("%8.2lf%c", r[i][j] / 100.0, j == M - 1 ? '\n' : ' ');
		}
	}
	return 0;
}


