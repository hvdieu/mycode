#include <bits/stdc++.h>

using namespace std;

const int N = 200000;

class node {
public:
    node *ll, *rr;
    long long val, f;
    void cnt(node *j, bool ok) {
        if (ok) ll = j;
        else rr = j;
    }
};

int n, q;
node *t[N + 10];

node* build(int lo, int hi) {
    node *i = new node();
    if (lo == hi) {
        i->val = 0;
        i->ll = i->rr = NULL;
        return i;
    }
    int mid = (lo + hi) / 2;
    i->cnt(build(lo, mid), true);
    i->cnt(build(mid+1, hi), false);
    i->val = i->ll->val + i->rr->val;
    return i;
}

 update(node *r1, int lo, int hi, int u, int v, int x) {
    node *r2 = new node();
    if (u <= lo && hi <= v) {

    }
}

int main() {
    freopen("input.txt", "r", stdin);
    scanf("%d%d", &n, &q);
    t[0] = build(1, n);
}
