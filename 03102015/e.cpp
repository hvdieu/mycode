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
const int NTRY = 5, MAXN = 10000000;
int f[MAXN + 9], nTest, n;

long long Mul(long long x, long long y, long long md)
{
    if(x <= 1000000000000000000ll / y)
    {
        return x * y % md;
    }
    int res = 0;
    for(int i = 0; y >> i; i++)
    {
        if(y >> i & 1)
        {
            res = (res + x) % md;
        }
        x = (x * 2) % md;
    }
    return res;
}

long long Pwr(long long x, long long n, long long md)
{
    int res = 1;
    for(int i = 0; n >> i; i++)
    {
        if(n >> i & 1)
        {
            res = Mul(res, x, md);
        }
        x = Mul(x, x, md) % md;
    }
    return res;
}

int Check(long long n)
{
    if(n < 2)
    {
        return 0;
    }
    if(n == 2 || n == 3 || n == 5 || n == 7 || n == 11)
    {
        return 1;
    }
    if(!(n % 2) || !(n % 3) || !(n % 5) || !(n % 7) || !(n % 11))
    {
        return 0;
    }
    for(int iTry = 1; iTry <= NTRY; iTry++)
    {
        int x = 3 + rand() % (n - 5);
        if(Pwr(x, n - 1, n) != 1)
        {
            return 0;
        }
    }
    return 1;
}

int main()
{
    ifstream cin("e.inp");
    //ofstream cout("e.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    f[0] = 2;
    for(int i = 1; i <= MAXN ; i++)
    {
        f[i] = f[i - 1];
        if(Check((long long)i * i * 2 + 3))
        {
            f[i]++;
        }
        if(i % 3 && Check(((long long)i * i * 2 + 1) / 3))
        {
            f[i]++;
        }
    }
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++)
    {
        cin >> n;
        cout << f[n] << "\n";
    }
    return 0;
}
