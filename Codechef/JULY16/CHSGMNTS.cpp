#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define FOR(i, f) for(auto i = f.begin(); i != f.end(); i++)
#define all(f) f.begin(), f.end()

const int N = 1000 + 5;

struct node {
    long long val;
    int head, tail;
};

int ntest, n, a[N];
bool avail[N];
long long ans;
vector<int> tmp;
vector<int> id[N];
node t[4*N];


void init() {
    ans = 0;
    sort(all(tmp));
    for(int i = 1; i <= n; i++) {
        a[i] = lower_bound(all(tmp), a[i]) - tmp.begin() + 1;
        id[a[i]].push_back(i);
    }
}

void init_tree(int i, int lo, int hi) {
    if (lo == hi) {
        t[i].val = t[i].head = t[i].tail = 1;
        return;
    }
    int mid = (lo + hi) / 2;
    init_tree(i*2, lo, mid);
    init_tree(i*2+1, mid+1, hi);
    t[i].head = t[i*2].head;
    if (t[i*2].head == mid-lo+1) t[i].head += t[i*2+1].head;
    t[i].tail = t[i*2+1].tail;
    if (t[i*2+1].tail == hi-mid) t[i].tail += t[i*2].tail;
    t[i].val = t[i*2].val + t[i*2+1].val + t[i*2].tail * t[i*2+1].head;
}

long long cal(long long len) {
    return (len + 1) * len / 2;
}

void update(int i, int lo, int hi, int u) {
    if (u < lo || u > hi) return;
    if (lo == hi) {
        t[i].val = t[i].head = t[i].tail = 0;
        return;
    }
    int mid = (lo + hi) / 2;
    update(i*2, lo, mid, u);
    update(i*2+1, mid+1, hi, u);
    t[i].head = t[i*2].head;
    if (t[i*2].head == mid-lo+1) t[i].head += t[i*2+1].head;
    t[i].tail = t[i*2+1].tail;
    if (t[i*2+1].tail == hi-mid) t[i].tail += t[i*2].tail;
    t[i].val = t[i*2].val + t[i*2+1].val + t[i*2].tail * t[i*2+1].head;
}

void push(int x) {
    FOR(i, id[x]) {
        avail[*i] = false;
        update(1, 1, n, *i);
    }
}

void solve() {
    for(int i = 1; i <= n; i++) {
        init_tree(1, 1, n);
        memset(avail, 1, sizeof avail);
        for(int j = i; j <= n; j++) {
            if (avail[j]) push(a[j]);
            //cout << i << ' ' << j << ' ' << t[1].val << "\n";
            ans += t[1].val;
        }
    }
    cout << ans / 2 << "\n";
}

int main() {
    //ifstream cin("in.txt");
    cin >> ntest;
    while (ntest--) {
        tmp.clear();
        cin >> n;
        for(int i = 1; i <= n; i++) {
            cin >> a[i];
            tmp.push_back(a[i]);
            id[i].clear();
        }
        init();
        solve();
    }
}
