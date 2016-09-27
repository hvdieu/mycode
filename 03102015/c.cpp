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
const int MD = 1000000007;
int nTest, n, m;

long long Pwr(long long x, long long n)
{
    long long res = 1;
    for(int i = 0; n >> i; i++)
    {
        if(n >> i & 1)
        {
            res = res * x % MD;
        }
        x = x * x % MD;
    }
    return res;
}

int main()
{
    //ifstream cin("c.inp");
    //ofstream cout("c.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++)
    {
        cin >> n >> m;
        cout << Pwr(2, (long long)(n - 1) * (m - 1)) << "\n";
    }
    return 0;
}
