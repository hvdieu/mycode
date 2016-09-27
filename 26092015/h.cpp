#include <iostream>
#include <fstream>
#include <algorithm>
#include <complex>
using namespace std;
const long double EPS = 0.1;
int a, b, c, k, nTest;
string ans;

long double Cal(int dau, long double a, long double b)
{
    if(!dau)
    {
        return a + b;
    }
    if(dau == 1)
    {
        return a - b;
    }
    if(dau == 2)
    {
        return a * b;
    }
    return a / b;
}

void Sol(int a, int b, int c)
{
    for(int dau1 = 0; dau1 < 4; dau1++)
    {
        for(int dau2 = 0; dau2 < 4; dau2++)
        {
            if(dau2 == 3 && !c)
            {
                continue;
            }
            if(abs(Cal(dau2, Cal(dau1, a, b), c) - k) <= EPS)
            {
                ans = "Possible";
                return;
            }
            if(abs(Cal(dau2, a, Cal(dau1, b, c)) - k) <= EPS)
            {
                ans = "Possible";
                return;
            }
        }
    }
}

int main()
{
    //ifstream cin("h.inp");
    //ofstream cout("h.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++)
    {
        cin >> a >> b >> c >> k;
        ans = "Impossible";
        Sol(a, b, c);
        Sol(a, c, b);
        Sol(b, a, c);
        Sol(b, c, a);
        Sol(c, a, b);
        Sol(c, b, a);
        cout << ans << "\n";
    }
    return 0;
}
