#include <iostream>
#include <fstream>
#include <sstream>
#include <iomanip>
#include <algorithm>
#include <complex>
#include <locale>
#include <vector>
#include <deque>
#include <queue>
#include <set>
#include <map>
#include <bitset>
using namespace std;
const int MAXN = 250000;
int nTest, q;
long long a[MAXN + 9];

int main()
{
    ifstream cin("f.inp");
    ofstream cout("f.ans");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++)
    {
        cout << "Case " << iTest << ":\n";
        fill(a, a + MAXN + 1, 0);
        cin >> q;
        for(int iQ = 1; iQ <= q; iQ++)
        {
            char ch;
            cin >> ch;
            if(ch == 'A')
            {
                int l, h;
                cin >> l >> h;
                for(int i = l; i <= h; i++)
                {
                    a[i] += i - l + 1;
                }
            }
            else if(ch == 'B')
            {
                int l, h;
                cin >> l >> h;
                for(int i = l; i <= h; i++)
                {
                    a[i] += h - i + 1;
                }
            }
            else if(ch == 'C')
            {
                int l, h, val;
                cin >> l >> h >> val;
                for(int i = l; i <= h; i++)
                {
                    a[i] = val;
                }
            }
            else
            {
                int l, h;
                cin >> l >> h;
                long long ans = 0;
                for(int i = l; i <= h; i++)
                {
                    ans += a[i];
                }
                cout << ans << "\n";
            }
        }
    }
    return 0;
}
