#include <bits/stdc++.h>

using namespace std;

int cnt[10];

int main() {
    for(int i = 0; i < 6; i++) {
        int x; cin >> x;
        cnt[x]++;
    }
    for(int i = 1; i <= 9; i++)
        if (cnt[i] >= 4) {
            if (cnt[i] == 6) cout << "Elephant";
            else {
                for(int i = 1; i <= 9; i++)
                    if (cnt[i] == 1) {
                        cout << "Bear"; return 0;
                    } else if (cnt[i] == 2){
                        cout << "Elephant"; return 0;
                    }
            }
            return 0;
        }
    cout << "Alien";
}
