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

const int N = 100 + 5;

int ntest, n;
int c[7], score[N];
bool flag;

int main() {
   // freopen("in.txt","r",stdin);
    cin >> ntest;
    while (ntest--) {
        cin >> n;
        int j = 0, m = 0;
        flag = false;
        For(i, 1, n) {
            cin >> m;
            reset(c, 0);
            REP(j, m) {
                int kind; cin >> kind;
                c[kind]++;
            }
            sort(c+1, c+7);
            score[i] = m + c[1]*4 + (c[2] - c[1]) * 2 + (c[3] - c[2]);
            if (score[i] > score[j]) j = i, flag = false;
            else if (score[i] == score[j]) flag = true;
        }
        if (flag) cout << "tie\n";
        else if (j == 1) cout << "chef\n";
        else cout << j << "\n";
    }
}


