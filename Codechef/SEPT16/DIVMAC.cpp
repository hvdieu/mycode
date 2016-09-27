#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define REP(i, n) for(int i = 0; i < n; i++)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define getbit(x, i) ((x >> (i-1)) & 1LL)
#define onbit(x, i) (x | (1LL << (i-1)))
#define offbit(x, i) (x & ~(1 << (i-1)))

const int N = 1e5 + 5;
const int MAX = 1e6;

int ntest, n, m;
int a[N];
int p[MAX + 5];
int cnt[N];
int pre[N], step[N];
int t[4*N];
vector<int> divisors[N];

void sieve() {
    int ss = int(sqrt(MAX));
    For(i, 2, ss) if (!p[i])
        for(int j = i*i; j <= MAX; j += i) p[j] = i;
}

void findDivisor(int i) {
    int n = a[i]; divisors[i].clear();
    while (p[n]) {
        int j = p[n];
        while (n % j == 0) {
            n /= j;
            divisors[i].pb(j);
        }
    }
    if (n > 1) divisors[i].pb(n);
    sort(all(divisors[i]));
}

int findPre(int i) {
    if (i < 1) return i;
    if (cnt[i] != sz(divisors[i])) return i;
    pre[i] = findPre(pre[i]);
    return pre[i];
}

int findStep(int i) {
	if (i > n) return i;
	if (cnt[i] != sz(divisors[i])) return i;
	step[i] = findStep(step[i]);
	return step[i];
}

void init(int i, int lo, int hi) {
    if (lo == hi) {
        int u = lo;
        if (cnt[u] == sz(divisors[u])) {
            t[i] = 1;
        } else t[i] = divisors[u][cnt[u]];
        return;
    }
    int mid = (lo + hi) / 2;
    init(i*2, lo, mid);
    init(i*2+1, mid+1, hi);
    t[i] = max(t[i*2], t[i*2+1]);
}

void update(int i, int lo, int hi, int u) {
    if (lo > u || hi < u) return;
    if (lo == hi) {
        if (cnt[u] == sz(divisors[u])) {
            t[i] = 1;
        } else t[i] = divisors[u][cnt[u]];
        return;
    }
    int mid = (lo + hi) / 2;
    update(i*2, lo, mid, u);
    update(i*2+1, mid+1, hi, u);
    t[i] = max(t[i*2], t[i*2+1]);
}

int get(int i, int lo, int hi, int u, int v) {
    if (lo > v || hi < u) return 0;
    if (u <= lo && hi <= v) return t[i];
    int mid = (lo + hi) / 2;
    return max(get(i*2, lo, mid, u, v), get(i*2+1, mid+1, hi, u, v));
}

void modify(int L, int R) {
    for(int i = L; i <= R; i = findStep(step[i])) {
       // cout << i << ' ';
        if (cnt[i] < sz(divisors[i])) {
            cnt[i]++;
            if (cnt[i] == sz(divisors[i])) {
                int p = findPre(pre[i]), q = findStep(step[i]);
                step[p] = q; pre[q] = p;
                update(1, 1, n, i);
            } else if (divisors[i][cnt[i]] != divisors[i][cnt[i]-1])
                update(1, 1, n, i);
        }
    }
  //  cout << '\n';
}

int main() {
    ios_base::sync_with_stdio(false);
    //freopen("in.txt","r",stdin);
    sieve();
    scanf("%d\n", &ntest);
    while (ntest--) {
        scanf("%d%d\n", &n, &m);
        For(i, 1, n) {
            step[i] = i+1;
            cnt[i] = 0;
            pre[i] = i-1;
            scanf("%d", a+i);
            findDivisor(i);
            //FOR(x, divisors[i]) cout << *x << " "; cout << "\n";
        }
        init(1, 1, n);
        int kind, L, R;
        REP(i, m) {
            scanf("%d%d%d\n", &kind, &L, &R);
            if (!kind) modify(L, R);
            else printf("%d ", get(1, 1, n, L, R));
            //For(i, 1, n) cout << divisors[i][cnt[i]] << ' '; cout << "\n";
        }
        printf("\n");
        //For(i, 1, n) cout << divisors[i][cnt[i]] << ' '; cout << "\n";
    }
}


