#include <algorithm>
#include <cassert>
#include <cstdio>
#include <cstring>
#include <functional>
#include <iomanip>
#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <stack>
#include <string>
#include <vector>

constexpr int N = 500010;

int a[N];
int pos[N];
std::vector<int> vals;

struct Node {
    int left;
    int right;
    int count;
} nodes[N * 22];

int ptr = 0;
int root[N];
int tree[N];

void build(int& x, int left, int right) {
    x = ++ptr;
    if (left < right) {
        int middle = (left + right) / 2;
        build(nodes[x].left, left, middle);
        build(nodes[x].right, middle + 1, right);
    }
}

int update(int x, int left, int right, int value) {
    int ret = ++ptr;
    nodes[ret].left = nodes[x].left;
    nodes[ret].right = nodes[x].right;
    nodes[ret].count = nodes[x].count + 1;
    if (left < right) {
        int middle = (left + right) / 2;
        if (value < middle + 1) nodes[ret].left = update(nodes[x].left, left, middle, value);
        else nodes[ret].right = update(nodes[x].right, middle + 1, right, value);
    }
    return ret;
}

int query(int x, int left, int right, int qLeft, int qRight) {
    if (qLeft <= left && right <= qRight) return nodes[x].count;
    int middle = (left + right) / 2;
    if (qRight < middle + 1) return query(nodes[x].left, left, middle, qLeft, qRight);
    if (qLeft > middle) return query(nodes[x].right, middle + 1, right, qLeft, qRight);
    return query(nodes[x].left, left, middle, qLeft, qRight) + query(nodes[x].right, middle + 1, right, qLeft, qRight);
}

void update(int pos) {
    while (pos < N) {
        tree[pos]++;
        pos += pos & -pos;
    }
}

int query(int pos) {
    int ret = 0;
    while (pos > 0) {
        ret += tree[pos];
        pos &= pos - 1;
    }
    return ret;
}

int main(int argc, const char* argv[]) {
//    freopen("/Volumes/SSD-Xcode/Android/projects/mep/mepcpp/mepcpp/in", "r", stdin);
    std::ios::sync_with_stdio(false);
    std::cin.tie(nullptr);
    int n;
    std::cin >> n;
    for (int i = 1; i <= n; ++i) {
        std::cin >> a[i];
        pos[a[i]] = i;
    }
    build(root[n + 1], 1, n);
    for (int i = n; i >= 1; --i) {
        root[i] = update(root[i + 1], 1, n, a[i]);
    }
    int best_inverse = 0;
    std::pair<int, int> best(0, 0);
    vals.push_back(n);
    for (int i = n - 1; i >= 1; --i) {
        int best_inner_inverse = 0;
        int best_inner = 0;
        for (int p = (int) vals.size() - 1; p >= 0; --p) {
            int j = vals[p];
            if (a[i] > a[j]) {
                int cnt = 1;
                if (i + 1 < j && a[j] + 1 < a[i]) {
                    if (i + 10 > j) {
                        int t = 0;
                        for (int k = i + 1; k < j; ++k) {
                            t += a[j] < a[k] && a[k] < a[i];
                        }
                        cnt += t * 2;
                    } else if (a[j] + 10 > a[i]) {
                        int t = 0;
                        for (int k = a[j] + 1; k < a[i]; ++k) {
                            t += i < pos[k] && pos[k] < j;
                        }
                        cnt += t * 2;
                    } else {
                        int x = query(a[i] - 1) - query(a[j]);
                        int y = query(root[j + 1], 1, n, a[j] + 1, a[i] - 1);
                        cnt += (x - y) * 2;
                    }
                }
                if (cnt > best_inner_inverse) {
                    best_inner_inverse = cnt;
                    best_inner = j;
                }
            } else {
                break;
            }
        }
        update(a[i]);
        if (best_inner_inverse >= best_inverse) {
            best_inverse = best_inner_inverse;
            best = std::make_pair(i, best_inner);
        }
        if (a[vals.back()] > a[i]) {
            if (i + 1 == vals.back()) {
                vals.pop_back();
            }
            vals.push_back(i);
        }
    }
    if (best_inverse > 0) {
        std::cout << best.first << ' ' << best.second;
    } else {
        std::cout << "Cool Array";
    }
}