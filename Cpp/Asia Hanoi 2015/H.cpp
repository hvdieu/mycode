#include <bits/stdc++.h>

using namespace std;

const int N = int(2e5) + 10;

int s[N], p[N], q[N], n, nTest;
vector<int> Q[N];
int st[N], top, ans[N];

void goLeft() {
    s[0] = 0; s[n+1] = int(1e9) + 1;
    st[0] = 0; top = 0;
    for(int i = 1; i <= n; i++) {
        while (top && s[st[top]] >= s[i]) top--;
        st[++top] = i;
        int j = st[max(0, top - q[i])];
        Q[j].push_back(i);
    }
}

void goRight() {
    st[0] = n+1; top = 0;
    for(int i = n; i >= 0; i--) {
        while (top && s[st[top]] <= s[i]) top--;
        st[++top] = i;
        for(int j = 0; j < Q[i].size(); j++) {
            int u = Q[i][j];
            ans[u] = st[max(0, top - p[u])];
        }
    }
}

int main() {
    ios_base::sync_with_stdio(false);
    ifstream cin("input.txt");
    //ofstream cout("output.txt");
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++) {
        cin >> n;
        for(int i = 1; i <= n; i++) cin >> s[i];
        for(int i = 1; i <= n; i++) cin >> p[i];
        for(int i = 1; i <= n; i++) cin >> q[i];
        goLeft();
        goRight();
        for(int i = 1; i <= n; i++) cout << ans[i] << ' '; cout << "\n";
    }
}
