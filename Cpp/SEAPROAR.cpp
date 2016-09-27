#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))

const int NN = 200010;

unsigned X; // we assume that unsigned is a 32bit integer type

void srand1(unsigned S){
  X = S;
}

unsigned nextInteger1(void){
  X = X * 1103515245 + 12345;
  return (X / 65536) % 32768;
}

void generator1(int N, unsigned S, int A[]){
  srand1(S);
  for(int i=1;i<=N;i++){
    A[i] = nextInteger1() % 2;
  }
}
/* ------------------ end here -----------------------*/

/* ------------------ start here ---------------------*/
unsigned x, y, z, w; // we assume that unsigned is a 32bit integer type

void srand2(unsigned S){
  x = S;
  y = x * S;
  z = y * S;
  w = z * S;
}

unsigned nextInteger2(void){
  unsigned t = x ^ (x << 11);
  x = y; y = z; z = w;
  return w = (w ^ (w >> 19)) ^ (t ^ (t >> 8));
}

void generator2(int N, unsigned S, int A[]){
  srand2(S);
  for(int i=1;i<=N;i++){
    A[i] = nextInteger2() % 2;
  }
}
/* ------------------ end here -----------------------*/

int a[NN];

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    generator1(67, 1, a);
    For(i, 1, 67) printf("%d", a[i]); printf("\n");
    generator2(67, 1, a);
    For(i, 1, 67) printf("%d", a[i]); printf("\n");
    generator1(67, 3, a);
    For(i, 1, 67) printf("%d", a[i]); printf("\n");
    generator1(67, 4, a);
    For(i, 1, 67) printf("%d", a[i]); printf("\n");
    generator1(67, 5, a);
    For(i, 1, 67) printf("%d", a[i]); printf("\n");
    generator1(67, 6, a);
    For(i, 1, 67) printf("%d", a[i]); printf("\n");
}
