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
const int MAXN = 18, MAXM = 100, MAXS = MAXN * MAXM;
int nTest, n, m, sum[MAXM + 9];
long long f[MAXN + 9][MAXS * 2 + 9][MAXM + 9];

long long Dp(int pos, int dif, int carry)
{
    if(pos > n)
    {
        return !(dif - sum[carry]);
    }
    if(f[pos][dif + MAXS][carry] != -1)
    {
        return f[pos][dif + MAXS][carry];
    }
    f[pos][dif + MAXS][carry] = 0;
    for(int i = 0; i <= 9; i++)
    {
        int _pos = pos + 1;
        int _dif = dif + i - (i * m + carry) % 10;
        int _carry = (i * m + carry) / 10;
        f[pos][dif + MAXS][carry] += Dp(_pos, _dif, _carry);
    }
    return f[pos][dif + MAXS][carry];
}

int main()
{
    //ifstream cin("d.inp");
    //ofstream cout("d.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    for(int i = 0; i <= MAXM; i++)
    {
        sum[i] = 0;
        int tmp = i;
        while(tmp > 0)
        {
            sum[i] += tmp % 10;
            tmp /= 10;
        }
    }
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++)
    {
        cin >> n >> m;
        fill(f[0][0], f[n + 1][0], -1);
        cout << Dp(1, 0, 0) << "\n";
    }
    return 0;
}
