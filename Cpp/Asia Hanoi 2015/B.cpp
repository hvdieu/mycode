#include <bits/stdc++.h>

using namespace std;

typedef pair<int, int> point;

#define For(i, a, b) for(int i = a; i <= b; i++)
#define x first
#define y second

const int N = 1000 + 10;

int nTest, n;
point p[N];
vector<pair<point, point>> Q;

point make_vector(point A, point B) { //Thay vì dùng góc, mình sinh ra vector tối giản tương ứng với đường chéo
    int xx = A.x - B.x, yy = A.y - B.y;
    if (xx < 0) xx *= -1, yy *= -1;
    if (!xx) return point(0, yy / abs(yy));
    if (!yy) return point(xx / abs(xx), 0);
    int zz = __gcd(abs(xx), abs(yy));
    return point(xx / zz, yy / zz);
}

long long C2(int n) { //Trả về tổ hợp chập 2 của n
    return (long long)n * (n - 1) / 2;
}

void solve() {
    Q.clear(); // mảng Q có 2 phần tử, first là trung điểm, second là vector tương ứng với đường chéo
    For(i, 1, n) For(j, i+1, n)
    Q.push_back(make_pair(point(p[i].x + p[j].x, p[i].y + p[j].y), make_vector(p[i], p[j])));
    sort(Q.begin(), Q.end());
    int i = 0;
    long long ans = 0;
    while (i < Q.size()) {
        int j = i;
        while (j < Q.size() && Q[i].first == Q[j].first) j++; // Đoạn i -> j-1 có trung điểm giống nhau
        ans += C2(j - i);
        int dem = 1;
        for(int k = i + 1; k < j; k++)
            if (Q[k].second == Q[k-1].second) dem++; 
            else {
                ans -= C2(dem); // Trừ những đoạn có góc bằng nhau
                dem = 1;
            }
        ans -= C2(dem); // Trừ nốt 
        i = j; // Xét đoạn tiếp theo
    }
    cout << ans << endl;
}

int main() {
    ios_base::sync_with_stdio(false);
    cin >> nTest;
    For(iTest, 1, nTest) {
        cin >> n;
        For(i, 1, n) cin >> p[i].x >> p[i].y; // mảng p chứa N điểm
        solve();
    }
}


