#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define all(f) f.begin(), f.end()
#define pb push_back

const int N = 200000 + 10;

int n, a[N], b[N];
vector<int> q;
int pA[N], pB[N], tA, tB, posA[2*N], posB[2*N];
long long tmp, ans;

void init() {
    sort(q.begin(), q.end());
    For(i, 1, n) a[i] = lower_bound(all(q), a[i]) - q.begin() + 1;//, cout << a[i] << ' '; cout << "\n";
    For(i, 1, n) b[i] = lower_bound(all(q), b[i]) - q.begin() + 1;//, cout << b[i] << ' '; cout << "\n";

}

int cal(int x) {
    return max(0, - max(pA[posA[x]-1], pB[posB[x]-1]) + min(pA[posA[x]], pB[posB[x]]));
}

void pushA(int i, int x) {
    while (tA && a[pA[tA]] <= x) {
        int y = a[pA[tA]];
        if (posB[y]) tmp -= cal(y);
        posA[y] = 0;
        tA--;
    }
    pA[++tA] = i; posA[x] = tA;
    if (posB[x]) tmp += cal(x);
}

void pushB(int i, int x) {
    while (tB && b[pB[tB]] >= x) {
        int y = b[pB[tB]];
        if (posA[y]) tmp -= cal(y);
        posB[y] = 0;
        tB--;
    }
    pB[++tB] = i; posB[x] = tB;
    //cout << posA[x] << ' ';
    if (posA[x]) tmp += cal(x);
}

void solve() {
    For(i, 1, n) {
        pushA(i, a[i]);
        pushB(i, b[i]);
        ans += tmp;
        //cout << ans << ' ';
    }
}

int main() {
    //ifstream cin("input.txt");
    cin >> n;
    for(int i = 1; i <= n; i++) cin >> a[i], q.push_back(a[i]);
    for(int i = 1; i <= n; i++) cin >> b[i], q.push_back(b[i]);
    init();
    //cout << "done\n";
    solve();
    cout << ans;
}
