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
#define N 100
#define BASE 1000000007
#define NUM 1
#define MO -1
#define DONG -2
#define CONG -3
#define TRU -4
#define NHAN -5

int m, n, ntest;
int val[27];
char a[N], b[N];
int st[N], top;

void fix(char s[]) {
    int n = strlen(s+1);
    For(i, 1, n) if (s[i] >= 'A' && s[i] <= 'Z') s[i] = s[i] + 32;
}

void add(int &a, int b) {
    a += b; if (a >= BASE) a -= BASE;
}

void sub(int &a, int b) {
    a -= b; if (a < 0) a += BASE;
}

void mul(int &a, int b) {
    a = (ll(a) * b) % BASE;
}

int gt(char c) {
    if (c >= '0' && c <= '9') return int(c) - int('0');
    return val[c - 'a'];
}

int cal(char s[]) {
    top = 0;
    int n = strlen(s+1);
    int i = 0;
    while (i < n) {
        i++;
        if (s[i] == '(') st[++top] = MO;
        else if (s[i] == '+') st[++top] = CONG;
        else if (s[i] == '-') st[++top] = TRU;
        else if (s[i] == '*') st[++top] = NHAN;
        else if (s[i] == ')') {
            int j = top; while (st[j] != MO) j--; j += 2;
            int u = j - 1;
            for(j; j <= top; j += 2)
                if (st[j] == CONG) add(st[u], st[j+1]); else sub(st[u], st[j+1]);
            top = u;
            st[top-1] = st[top]; top--;
            while (st[top-1] == NHAN) mul(st[top-2], st[top]), top -= 2;
        } else { st[++top] = gt(s[i]);
                 while (st[top-1] == NHAN) mul(st[top-2], st[top]), top -= 2;
               }
    }
    int j, u;
    if (st[1] == CONG || st[1] == TRU) u = 2; else u = 1;
    if (u == 2 && st[1] == TRU) st[2] = -st[2] + BASE;
    j = u + 1;
    for(j; j <= top; j += 2) if (st[j] == CONG) add(st[u], st[j+1]); else sub(st[u], st[j+1]);
    return st[u];
}

int main() {
   // freopen("input.txt","r",stdin);
   // freopen("output.txt","w",stdout);
    scanf("%d\n", &ntest);
    For(test, 1, ntest) {
        scanf("%s\n", a+1);
        scanf("%s\n", b+1);
        fix(a); fix(b);
        bool flag = true;
        For(nn, 1, NUM) {
            For(i, 0, 25) val[i] = (rand() % 10) + 1;
            int x = cal(a);
			int y = cal(b);
            if (x != y) {
                flag = false; break;
            }
        }
        if (flag) printf("YES\n"); else printf("NO\n");
    }
}
