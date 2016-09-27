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
const int BASE1 = 1000000007, BASE2 = 1000000009;
int n, ans;
string a, b;

long long Pwr(long long x, int n)
{
    long long res = 1;
    for(int i = 0; n >> i; i++)
    {
        if(n >> i & 1)
        {
            res *= x;
        }
        x *= x;
    }
    return res;
}

int Pwr(int x, int n, int md)
{
    int res = 1;
    for(int i = 0; n >> i; i++)
    {
        if(n >> i & 1)
        {
            res = (long long)res * x % md;
        }
        x = (long long)x * x % md;
    }
    return res;
}

int main()
{
    //ifstream cin("j.inp");
    //ofstream cout("j.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    cin >> n >> a >> b;
    int num = 0;
    vector<pair<long long, pair<int, int> > > v, aa, bb;
    for(int i = 0; i < a.size(); i++)
    {
        if(a[i] >= '0' && a[i] <= '9')
        {
            num = num * 10 + a[i] - '0';
        }
        else
        {
            if(num)
            {
                v.push_back(make_pair(Pwr(47, num), make_pair(Pwr(47, num, BASE1), Pwr(47, num, BASE2))));
                aa.push_back(v.back());
                num = 0;
            }
            if(a[i] == ')')
            {
                pair<long long, pair<int, int> > x = v.back();
                v.pop_back();
                pair<long long, pair<int, int> > y = v.back();
                v.pop_back();
                v.push_back(make_pair(x.first + y.first, make_pair((x.second.first + y.second.first) % BASE1, (x.second.second + y.second.second) % BASE2)));
                aa.push_back(v.back());
            }
        }
    }
    v.clear();
    num = 0;
    for(int i = 0; i < b.size(); i++)
    {
        if(b[i] >= '0' && b[i] <= '9')
        {
            num = num * 10 + b[i] - '0';
        }
        else
        {
            if(num)
            {
                v.push_back(make_pair(Pwr(47, num), make_pair(Pwr(47, num, BASE1), Pwr(47, num, BASE2))));
                bb.push_back(v.back());
                num = 0;
            }
            if(b[i] == ')')
            {
                pair<long long, pair<int, int> > x = v.back();
                v.pop_back();
                pair<long long, pair<int, int> > y = v.back();
                v.pop_back();
                v.push_back(make_pair(x.first + y.first, make_pair((x.second.first + y.second.first) % BASE1, (x.second.second + y.second.second) % BASE2)));
                bb.push_back(v.back());
            }
        }
    }
    sort(aa.begin(), aa.end());
    ans = 0;
    for(int i = 0; i < bb.size(); i++)
    {
        int pos = lower_bound(aa.begin(), aa.end(), bb[i]) - aa.begin();
        if(pos != aa.size() && aa[pos] == bb[i])
        {
            ans++;
        }
    }
    cout << ans << "\n";
    return 0;
}
