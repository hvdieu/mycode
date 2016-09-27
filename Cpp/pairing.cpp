#include <bits/stdc++.h>

using namespace std;

const int N = 1000 + 10;

int n;
string a[N], b[N];
char c[N];
int d[N];
bool dd[N];

int main() {
   // freopen("input.txt", "r", stdin);
    cin >> n;
    for(int i = 0; i < n; i++) {
        cin >> a[i]; cin >> d[i];
        cin >> b[i]; cin >> c[i];
    }
    memset(dd, true, sizeof(dd));
    int res = 0;
    for(int i = 0; i < n; i++) if (dd[i])
        for(int j = i+1; j < n; j++) if (dd[j])
    if (a[i] == a[j] && b[i] == b[j] && c[i] != c[j] && d[i] == d[j]) {
        res++;
        dd[i] = false;
        dd[j] = false;
        break;
    }
    cout << res;
}
