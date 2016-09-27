//Author: net12k44
#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <sstream>
#include <string>
#include <list>
#include <vector>
#include <map>
#include <set>
#include <queue>
#include <stack>
#include <ctime>
#include <algorithm> 

using namespace std;

#define For(i,a,b)  for(i=(a);i<=(b);++i)
#define Ford(i,a,b) for(i=(a);i>=(b);--i)
#define Rep(i,n)    for(i=0  ;i <(n);++i)
#define Repd(i,n)   for(i=(n-1);i>=0;--i)
#define FOR(i,a,b)  for(i=(a);i!=(b);i++)


#define pp  pair<int,int>
template<class T> void minimize( T &i , const T &j ) { if ( i > j ) i = j; }
template<class T> void maximize( T &i , const T &j ) { if ( i < j ) i = j; }


int NUM, AM; 
#define SIZE (1 << 16)
char BUFFER[SIZE+1], *pNum = BUFFER;
#define GET(NUM)\
{\
      if (!*pNum)\
      {\
            if (feof(stdin) ) memset(BUFFER,0,sizeof BUFFER);\
            else fread(BUFFER, 1, SIZE, stdin); pNum = BUFFER;\
      } NUM = *pNum++;\
}
#define IsNum(c) ( ('0' <= (c)) && ((c) <= '9' ) )
#define read(i)\
{\
      do  GET(NUM) while(!IsNum(NUM) && NUM!='-' );\
      if (NUM == '-') {AM=1; GET(NUM);} else AM=0;\
      i = NUM-'0'; GET(NUM);\
      while( IsNum(NUM) ) { i = i * 10 + (NUM-'0'); GET(NUM); }\
      if (AM) i = -i;\
}

int MAIN();

int main()
{int i,j,k,t;
	#ifndef ONLINE_JUDGE
		freopen("file.inp","r",stdin);
//		freopen("file.out","w",stdout);

		#ifdef TEST_JUDGE
			freopen("file.out","w",stdout);
		#endif
	#endif
	
	MAIN();
		
	 #ifndef ONLINE_JUDGE
            printf("\n");
            printf("%.2lf", (double) clock() / CLOCKS_PER_SEC);
      #endif
}



         
const int limit = 100000 + 5;

struct edge {
	int u , v , a , b , c , d , level;
	edge () {}
	void scan(int z) {
		read(u); read(v); read(a); read(b); read(c); read(d);
		level = z;
	}
	
	bool operator < ( const edge &X )  const{
		
		if ( a != X.a ) return a < X.a; else
		 return level < X.level;
	}
};
	
int m,n,P,T;
edge e[limit];
int *f[limit] , *a[limit];
int size[limit] , nn[limit];
int maxn;

void ktao(){
	int i;
	
	Rep(i,m) size[ e[i].u ]++;
	size[ P ] ++;
	For(i,1,n) {
		size[i]++;
		nn[i] = size[i];
		f[i] = (int *) malloc( size[i] * sizeof (int) );
		a[i] = (int *) malloc( size[i] * sizeof (int) );
		memset( f[i] , 0x3f , size[i] * sizeof (int) );
	}
	
	maxn = f[1][0];
	Rep(i,m) {
		int j = e[i].u;
		a[ j ][ --nn[j] ] = e[i].a;
	}
		
	For(i,1,n) 
		a[i][ --nn[i] ] = maxn;
		
	a[P][ --nn[P] ] = T;
	For(i,1,n) sort( a[i] , a[i] + size[i] );
	f[1][0] = 0;

}
	
void update( int i , int value , int k ) {
	
	int j = lower_bound( a[i] , a[i] + size[i] , value ) - a[i];
	minimize( f[i][j] , k );
}

int MAIN()
{int i,j,k,t;
	
	read(n); read(m); read(P); read(T);
	Rep(i,m) e[i].scan(i);
	
	ktao();
	sort( e , e + m );
	Rep(t , m){
		
		i = e[t].u , j = e[t].v;
		k = nn[i]++;
		if ( a[i][k] < e[t].a ) break;
		if (f[i][k] != maxn) update( j , e[t].d , f[i][k] + e[t].b - e[t].c );
		minimize( f[i][ nn[i] ] , f[i][k] );
	}
	
	i = lower_bound( a[P] , a[P] + size[P] , T ) - a[P];
	if (f[ P ][i] == maxn) printf("-1"); else printf("%d",f[P][i] + T);
		
		
	For(i,1,n) {
		free( a[i] );
		free( f[i] );
	}
}

