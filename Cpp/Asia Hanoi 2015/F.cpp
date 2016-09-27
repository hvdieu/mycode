#include <bits/stdc++.h>

using namespace std;

const int L = int(1e5) + 10;
const int N = int(1e4) + 10;
const int p = int(1e9) + 7; //
const char a[4] = {'A', 'C', 'G', 'T'};

int n, l;
string s[N], g;
long long h[L], pw[L];
vector<long long> hashTable;

int ord(char ch) { // Đổi kí tự ra hệ cơ số 4
    if (ch == 'A') return 0;
    if (ch == 'C') return 1;
    if (ch == 'G') return 2;
    return 3;
}

long long getHash(int i, int j) { // Trả về mã hash của xâu con g[i..j]
    return (h[j] - ((h[i-1] * pw[20]) % p) + p) % p;
}

void initHash() {
    pw[0] = 1; // Khởi tạo mảng 4^i mod p
    for(int i = 1; i < l; i++) {
        h[i] = (h[i-1] * 4 + ord(g[i])) % p; // h[i] là mã hash của g[1..i]
        pw[i] = (pw[i-1] * 4) % p;
    }
    for(int i = 1; i < l-19; i++) hashTable.push_back(getHash(i, i + 19)); // Xây dựng mảng hashTable chứa mã hash
    sort(hashTable.begin(), hashTable.end()); // sort mảng hashTable
}

int countHash(string s) { // Đếm số vị trí trong xâu g mà khớp hoàn toàn với xâu s
    long long hashNumber = 0;
    for(int i = 1; i <= 20; i++) hashNumber = (hashNumber * 4 + ord(s[i])) % p; // Tính mã hash của s
    return upper_bound(hashTable.begin(), hashTable.end(), hashNumber) - lower_bound(hashTable.begin(), hashTable.end(), hashNumber);
	// Hàm chặt nhị phân trả về số giá trị = hashNumber
}

int main() {
    ios_base::sync_with_stdio(false);
    cin >> n;
    for(int i = 1; i <= n; i++) cin >> s[i], s[i] = ' ' + s[i]; // Do string trong C++ đánh số từ 0 nên chèn thêm 1 kí tự ' ' vào đầu để xâu đánh số từ 1
    cin >> g; g = ' ' + g;
    l = g.size();
    initHash(); // Thủ tục sinh ra các mã hash của xâu con độ dài 20 trong g
    for(int i = 1; i <= n; i++) {
        int ans = countHash(s[i]); // Trường hợp s_i không khác kí tự nào
        for(int j = 1; j <= 20; j++) { // Thử từng vị trí khác nhau
            char backUp = s[i][j]; // Lưu lại kí tự ban đầu
            for(int c = 0; c < 4; c++) if (backUp != a[c]) { // Thử 3 kí tự còn lại
                s[i][j] = a[c]; // Thay thế
                ans += countHash(s[i]); // Tăng kết quả
            }
            s[i][j] = backUp; // Trả về kí tự ban đầu
        }
    cout << ans << "\n";
    }
}
