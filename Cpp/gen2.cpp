#include <algorithm>
#include <chrono>
#include <iomanip>
#include <iostream>
#include <random>
#include <queue>
#include <set>
#include <vector>

using namespace std;

const int N = 123456;
const int MAX = 1000000;

struct edge {
    int u, v; // edge from u to v
    int c;    // edge cost / weight / distance
    edge(const int u, const int v, const int c) : u(u), v(v), c(c) { }
};

unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
std::default_random_engine generator(seed);

long long random(long long f, long long t) {
    std::uniform_int_distribution<long long> d(f, t);
    long long r = d(generator);
    return r;
}

// generates a tree
void gen_tree(int n, const int THR, std::vector<edge>& vt);

int main() {
    freopen("input.txt", "w", stdout);
    std::cin.tie(nullptr);
    std::ios::sync_with_stdio(false);
    int n = 1000;
    int q = 1000;
    cout << n << ' ' << q << '\n';
    while (q--) {
        int t = rand() % 2 + 1;
        int x = random(1, n);
        int y = random(1, n);
        if (x > y) swap(x, y);
        cout << t << ' ' << x << ' ' << y << '\n';
    }
}

// pop a vertex from queue
inline
int getv(std::priority_queue<std::pair<int, int>>& que) {
    int r = que.top().second;
    que.pop();
    return r;
}

// push a vertex into queue
inline
void addv(const int v, std::priority_queue<std::pair<int, int>>& que) {
    que.push(std::make_pair(random(1, 100000), v));
}

void gen_tree(const int n, const int THR, std::vector<edge>& vt) {
  std::priority_queue<std::pair<int, int>> qin, qout;
  int root = random(1, n);
  root = 1;
  // qin contains vertices already in the tree
  addv(root, qin);
  // qout contains vertices have yet in the tree
  for (int i = 1; i <= n; ++i) if (i != root) addv(i, qout);
  // repeatly pop 2 vertices at once from queue to create an edge between them
  for (int i = 1; i < n; ++i) {
    int u = getv(qin);  addv(u, qin);
    int v = getv(qout); addv(v, qin);
    int c = random(1, THR);
    vt.push_back(edge(u, v, c));
  }
}
