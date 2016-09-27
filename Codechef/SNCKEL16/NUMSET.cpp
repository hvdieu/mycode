#include <bits/stdc++.h>

using namespace std;

typedef pair<int, int> ii;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define REP(i, n) for(int i = 0; i < n; i++)
#define bit(x, i) ((x >> i) & 1)
#define onbit(x, i) (x | (1 << i))

const int N = 1e3 + 10;
const int id[11] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31};

int ntest, n, f[N][1 << 11];
ii tt[N];
int l[N];

void tach(int x, int i) {
    int ss = int(sqrt(x));
    tt[i].first = tt[i].second = 0;
    For(j, 2, ss)
        if (x % j == 0) {
            if (j > 31) tt[i].second = j;
            else {
                int ii = 0;
                while (id[ii] != j) ii++;
                tt[i].first = onbit(tt[i].first, ii);
            }
            while (x % j == 0) x /= j;
        }
    if (x > 1) {
        if (x > 31) tt[i].second = x;
        else {
            int ii = 0;
            while (id[ii] != x) ii++;
            tt[i].first = onbit(tt[i].first, ii);
        }
    }
}

bool cmp(ii a, ii b) {
    return a.second < b.second;
}

void solve() {
    sort(tt+1, tt+n+1, cmp);
    For(i, 1, n)
        if (tt[i].second != tt[i-1].second) l[i] = i;
        else if (!tt[i].second) l[i] = i;
        else l[i] = l[i-1];
    int res = 0;
    For(i, 1, n)
        REP(S, 1 << 11) {
            f[i][S] = f[i-1][S];
            if ((S | tt[i].first) == S)
                f[i][S] = max(f[i][S], 1 + f[l[i]-1][S & (~tt[i].first)]);
            if (i == n) res = max(res, f[i][S]);
        }
    cout << res << "\n";
}

int main() {
    //freopen("in.txt", "r", stdin);
    REP(i, 1 << 11) f[0][i] = -100000;
    f[0][0] = 0;
    cin >> ntest;
    while (ntest--) {
        cin >> n;
        For(i, 1, n) {
            int x;
            cin >> x;
            tach(x, i);
            //cout << tt[i].first << ' ' << tt[i].second << "\n";
        }
        solve();
    }
}
