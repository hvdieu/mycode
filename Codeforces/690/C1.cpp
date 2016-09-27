#include <bits/stdc++.h>

using namespace std;

#define For(i, a, b) for(int i = a; i <= b; i++)

const int N = 1001;

int n, m;
int root[N];

int getroot(int u) {
    if (root[u] != u) root[u] = getroot(root[u]);
    return root[u];
}

int main() {
    //ifstream cin("in.txt");
    cin >> n >> m;
    //int u, v; cin >> u >> v; cout << u << ' ' << v << "\n";
   // cout << n << ' ' << m << "\n";
    if (m != n-1) cout << "no";
    else {
        For(i, 1, n) root[i] = i;
        For(i, 1, m) {
            int u, v;
            cin >> u >> v;
            int r1 = getroot(u), r2 = getroot(v);
           // cout << r1 << ' ' << r2 << "\n";
            if (r1 == r2) {
                cout << "no";
                return 0;
            } else root[r1] = r2;
        }
        cout << "yes";
    }

}
