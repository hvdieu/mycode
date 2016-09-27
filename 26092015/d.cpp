#include <iostream>
#include <fstream>
#include <vector>
using namespace std;
const int COE = 37, MAXN = 1000000;
int n;
string s;
long long hsh[MAXN + 9], pwr[MAXN + 9];
vector<int> ans;

int GetHash(int l, int h)
{
    return hsh[h] - hsh[l - 1] * pwr[h - l + 1];
}

int Lcp(int x, int y)
{
    int low = 0, high = min(n - x + 1, n - y + 1);
    while(low < high)
    {
        int mid = (low + high + 1) / 2;
        if(GetHash(x, x + mid - 1) == GetHash(y, y + mid - 1))
        {
            low = mid;
        }
        else
        {
            high = mid - 1;
        }
    }
    return low;
}

int main()
{
    //ifstream cin("d.inp");
    //ofstream cout("d.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    cin >> s;
    s = ' ' + s + (char)('a' - 1);
    n = s.size() - 1;
    pwr[0] = 1;
    for(int i = 1; i <= n; i++)
    {
        pwr[i] = pwr[i - 1] * COE;
        hsh[i] = hsh[i - 1] * COE + s[i] - 'a' + 2;
    }
    for(int i = 1; i < n; i++)
    {
        int j = i + 1;
        while(1)
        {
            while(s[j] > s[i])
            {
                j++;
            }
            int len = Lcp(i, j);
            if(s[j + len] < s[i + len])
            {
                ans.push_back(j - i);
                i = j - 1;
                break;
            }
            j += len;
        }
    }
    cout << ans.size();
    for(int i = 0; i < ans.size(); i++)
    {
        cout << " " << ans[i];
    }
    cout << "\n";
    return 0;
}
