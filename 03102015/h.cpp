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
string s, ans;

int main()
{
    //ifstream cin("h.inp");
    //ofstream cout("h.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    while(cin >> s)
    {
        ans = "YES";
        for(int i = 1; i <= s.size(); i++)
        {
            string tmp;
            int carry = 0;
            for(int j = (int)s.size() - 1; j >= 0; j--)
            {
                tmp.push_back(((s[j] - '0') * i + carry) % 10 + '0');
                carry = ((s[j] - '0') * i + carry) / 10;
            }
            if(carry)
            {
                ans = "NO";
                break;
            }
            string tmp2 = s;
            sort(tmp.begin(), tmp.end());
            sort(tmp2.begin(), tmp2.end());
            if(tmp != tmp2)
            {
                ans = "NO";
                break;
            }
        }
        cout << ans << "\n";
    }
    return 0;
}
