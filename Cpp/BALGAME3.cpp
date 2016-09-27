#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define l first
#define r second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 500010

struct node {
    char color;
    int len;
    int l, r;
};

struct Compare {
    bool operator () (const node &a, const node &b) {
        if (a.len != b.len) return a.len < b.len;
        return a.l > b.l;
    }
};

int n, tiep[N], last[N];
char s[N];
bool was[N];
priority_queue< node, vector<node>, Compare> heap;
node truoc[N], sau[N];

int main() {
    freopen("input.txt","r",stdin);
    freopen("output.txt","w",stdout);
    scanf("%s\n", s+1);
    n = strlen(s+1);
    int i = 1;
    node null; null.len = 0; null.r = null.l = 0;
    For(i, 0, n) truoc[i] = sau[i] = null;
    node cuoi = null;
    while (i <= n) {
        int j = i;
        node x;
        x.color = s[i];
        while (j < n && s[j+1] == s[i]) j++;
        x.len = j - i + 1; x.l = i; x.r = j;
        last[i] = j;
        truoc[i] = cuoi;
        sau[cuoi.r] = x;
        cuoi = x;
        heap.push(x);
        i = j + 1;
    }
    sau[0] = null;
    while (!heap.empty()) {
        node x = heap.top(); heap.pop();
        if (x.len == 1) break;
        if (!was[x.l]) {
            was[x.l] = true;
            printf("%c ", x.color);
            int l = x.l;
            while (l) {
                For(i, l, last[l]) printf("%d ", i);
                l = tiep[last[l]];
            }
            printf("\n");
            node a = truoc[x.l], b = sau[x.r];
            if (a.l == 149) {
            	bool flag = true;
			}
            sau[a.r] = b; truoc[b.l] = a;
            if (a.len && b.len && a.color == b.color) {
                was[b.l] = true;
                a.len += b.len;
                tiep[a.r] = b.l;
                a.r = b.r;
                sau[truoc[a.l].r] = a;
				truoc[sau[a.r].l] = a;
                heap.push(a);
            }
        }
    }
}
