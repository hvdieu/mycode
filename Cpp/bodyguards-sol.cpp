// solution written by Jan Katrenic
#include<iostream>
#include<vector>
#include<algorithm>
using namespace std;

typedef pair<long long, long long> point;
typedef vector<point> array;

bool solve(const array &A, const array &B) {
        array a, b;
        long long x=0, y=0;
        for (int i=A.size()-1; i>=0; --i) {
                x += A[i].second;
                a.push_back( point(x,A[i].first) );
        }
        for (int i=B.size()-1; i>=0; --i) {
                y += B[i].second;
                b.push_back( point(B[i].first,y) );
        }
        reverse(b.begin(),b.end());

        long long Sa=0, Sb=0, ax=0, bx=0, by=b[0].second;
        int i=0,j=0;
        while(1) {
                if (i==a.size()) break;
                if (j==b.size() || a[i].first < b[j].first) {
                        Sa += a[i].second * (a[i].first - ax);
                        ax = a[i].first;
                        Sb += by * (a[i].first - bx);
                        bx = a[i].first;
                        if (Sa>Sb) return false;
                        ++i;
                } else {
                        Sb += b[j].second * (b[j].first - bx);
                        by = (j+1==b.size()) ? 0 : b[j+1].second;
                        bx = b[j].first;
                        ++j;
                }
        }
   return true;
}

int main() {
        array A, B;
        long long na, nb, deg, cnt;
        cin >> na;
        for (int i=0; i<na; i++) { cin >> deg >> cnt; A.push_back(point(deg,cnt)); }
        cin >> nb;
        for (int i=0; i<nb; i++) { cin >> deg >> cnt; B.push_back(point(deg,cnt)); }
        sort(A.begin(),A.end());
        sort(B.begin(),B.end());
        cout << int(solve(A,B)) << endl;
}
