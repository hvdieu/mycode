#include <iostream>
#include <cstdio>
#include <queue>

using namespace std;

#define FOR(i, a, b) for(int i = a; i <= b; i++)
#define REP(i, a, b) for(int i = a; i >= b; i--)

struct CALL{
    CALL(int x, int y, int z) :
    value1(x), value2(y), value3(z) {}
    int value1;
    int value2;
    int value3;

    void COUT() {
        cout << value1 << ' ' << value2 << ' ' << value3 << endl;
    }
};
bool operator > (const CALL &lhs,const CALL &rhs) {
//        if (lhs.value1 > rhs.value1) return true;
//        if (lhs.value1 < rhs.value1) return false;
//        if (lhs.value2 > rhs.value2) return true;
//        if (lhs.value2 < rhs.value2) return false;
        return (lhs.value3 > rhs.value3);
    }
//CALL ad[100];

int main() {
    priority_queue <CALL, vector<CALL>, greater<CALL> > H;

 //   REP(i, 3, 1) REP(j, 3, 1) REP(k, 3, 1) H.push(CALL(i, j, k));
//
    H.push(CALL(1, 2, 3));
    H.push(CALL(1, 2, 2));

    while ((int)H.size()) {
        CALL X = H.top();
        X.COUT();
        H.pop();
    }
//    init();
    return 0;
}



