#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
using namespace std;
const int MAXN = 2000000, oo = 1000000009;
int prime[MAXN + 9], nTest, n, ans;
vector<int> vPrime;

int main()
{
    //ifstream cin("c.inp");
    //ofstream cout("c.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    fill(prime + 2, prime + MAXN + 1, 1);
    for(int i = 2; i <= MAXN; i++)
    {
        if(prime[i])
        {
            vPrime.push_back(i);
            for(int j = i; (long long)i * j <= MAXN; j++)
            {
                prime[i * j] = 0;
            }
        }
    }
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++)
    {
        cin >> n;
        int nxt = lower_bound(vPrime.begin(), vPrime.end(), n) - vPrime.begin();
        int prv = upper_bound(vPrime.begin(), vPrime.end(), n) - vPrime.begin() - 1;
        ans = oo;
        if(nxt < vPrime.size())
        {
            ans = min(ans, vPrime[nxt] - n);
        }
        if(nxt >= 0)
        {
            ans = min(ans, n - vPrime[prv]);
        }
        cout << ans << "\n";
    }
    return 0;
}
