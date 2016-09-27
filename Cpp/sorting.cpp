#include "sorting.h"
#include <algorithm>
using namespace std;

int *s, *x, *y, *p, *q, n;
int obj[200005], cur[200005];
int orev[200005], crev[200005];

bool check(int K){
    for(int i = 0; i < n; i++) obj[i] = i; // khởi tạo obj
    for(int i = K-1; i >= 0; i--) swap(obj[x[i]], obj[y[i]]); // làm ngược lại K lượt swap của người 1
    for(int i = 0; i < n; i++) { // khởi tạo orev, cur, và crev
        orev[obj[i]] = i;
        cur[i] = s[i];
        crev[cur[i]] = i;
    }
    int j = 0;
    for(int i = 0; i < t; i++) {
        swap(obj[x[i]], obj[y[i]]); // swap obj của người chơi thứ nhất
        swap(cur[x[i]], cur[y[i]]); // swap cur theo x[i], y[i]
        crev[cur[x[i]]] = x[i]; // gán lại các giá trị crev, orev
        orev[obj[x[i]]] = x[i];
        crev[cur[y[i]]] = y[i];
        orev[obj[y[i]]] = y[i];
        while (j < n && crev[j] == orev[j]) j++; // sau khi swap sẽ có giá trị về đúng chỗ của mình
        if(j == n) { // nếu tất cả đã về đúng vị trí
            p[i] = q[i] = 0;
            continue;
        }
        int p1 = crev[j]; // người thứ 2 sẽ đổi chỗ crev[j] và orev[j], nếu j == n thì p1 = p2 = 0
        int p2 = orev[j];
        p[i] = p1; q[i] = p2; // gán vào kết quả
        swap(cur[p1], cur[p2]); // đổi chỗ cur ở 2 vị trí p1, p2
        crev[cur[p1]] = p1; crev[cur[p2]] = p2; // cập nhật lại crev
    }
    while (j < n && crev[j] == orev[j]) j++; // lượt cuối cùng chưa cập nhật lại j
    return (j == n); // nếu đã về hết vị trí trả về true, không thì trả về false
}

int findSwapPairs(int N, int S[], int M, int X[], int Y[], int P[], int Q[]) {
    n = N, s = S, x = X, y = Y, p = P, q = Q; // Gán vào mảng khác
    int l = 0, r = M;
	// Chặt nhị phân kết quả
    while (l != r) {  
        int m = (l+r)/2;
        if (check(m)) l = m;
        else r = m+1;
    }
    check(l);
    return l;
}
