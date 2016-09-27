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
const int LOGN = 17, MAXN = 250000, oo = 1000000009;
long long it[(1 << LOGN + 2) + 9], lzAdd[(1 << LOGN + 2) + 9], lzInc[(1 << LOGN + 2) + 9], lzAss[(1 << LOGN + 2) + 9];
int nTest, q;

void Build(int x, int low, int high)
{
    it[x] = 0;
    lzAdd[x] = 0;
    lzInc[x] = 0;
    lzAss[x] = oo;
    if(low == high)
    {
        return;
    }
    int mid = (low + high) / 2;
    Build(x * 2, low, mid);
    Build(x * 2 + 1, mid + 1, high);
}

void Add(int x, int low, int high, int val)
{
    it[x] += (long long)val * (high - low + 1);
    lzAdd[x] += val;
}

void Inc(int x, int low, int high, int val)
{
    it[x] += val * (long long)(low + high) * (high - low + 1) / 2;
    lzInc[x] += val;
}

void Ass(int x, int low, int high, int val)
{
    it[x] = (long long)val * (high - low + 1);
    lzAss[x] = val;
    lzAdd[x] = 0;
    lzInc[x] = 0;
}

void Down(int x, int low, int high)
{
    int mid = (low + high) / 2;
    if(lzAss[x] != oo)
    {
        Ass(x * 2, low, mid, lzAss[x]);
        Ass(x * 2 + 1, mid + 1, high, lzAss[x]);
        lzAss[x] = oo;
    }
    Add(x * 2, low, mid, lzAdd[x]);
    Add(x * 2 + 1, mid + 1, high, lzAdd[x]);
    lzAdd[x] = 0;
    Inc(x * 2, low, mid, lzInc[x]);
    Inc(x * 2 + 1, mid + 1, high, lzInc[x]);
    lzInc[x] = 0;
}

void Add(int x, int low, int high, int l, int h, int val)
{
    if(low > h || high < l)
    {
        return;
    }
    if(low >= l && high <= h)
    {
        Add(x, low, high, val);
        return;
    }
    Down(x, low, high);
    int mid = (low + high) / 2;
    Add(x * 2, low, mid, l, h, val);
    Add(x * 2 + 1, mid + 1, high, l, h, val);
    it[x] = it[x * 2] + it[x * 2 + 1];
}

void Inc(int x, int low, int high, int l, int h, int val)
{
    if(low > h || high < l)
    {
        return;
    }
    if(low >= l && high <= h)
    {
        Inc(x, low, high, val);
        return;
    }
    Down(x, low, high);
    int mid = (low + high) / 2;
    Inc(x * 2, low, mid, l, h, val);
    Inc(x * 2 + 1, mid + 1, high, l, h, val);
    it[x] = it[x * 2] + it[x * 2 + 1];
}

void Ass(int x, int low, int high, int l, int h, int val)
{
    if(low > h || high < l)
    {
        return;
    }
    if(low >= l && high <= h)
    {
        Ass(x, low, high, val);
        return;
    }
    Down(x, low, high);
    int mid = (low + high) / 2;
    Ass(x * 2, low, mid, l, h, val);
    Ass(x * 2 + 1, mid + 1, high, l, h, val);
    it[x] = it[x * 2] + it[x * 2 + 1];
}

long long Query(int x, int low, int high, int l, int h)
{
    if(low > h || high < l)
    {
        return 0;
    }
    if(low >= l && high <= h)
    {
        return it[x];
    }
    Down(x, low, high);
    int mid = (low + high) / 2;
    return Query(x * 2, low, mid, l, h) + Query(x * 2 + 1, mid + 1, high, l, h);
}

int main()
{
    //ifstream cin("f.inp");
    //ofstream cout("f.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++)
    {
        Build(1, 1, MAXN);
        cout << "Case " << iTest << ":\n";
        cin >> q;
        for(int iQ = 1; iQ <= q; iQ++)
        {
            char ch;
            cin >> ch;
            if(ch == 'A')
            {
                int l, h;
                cin >> l >> h;
                Add(1, 1, MAXN, l, h, -l + 1);
                Inc(1, 1, MAXN, l, h, 1);
            }
            else if(ch == 'B')
            {
                int l, h;
                cin >> l >> h;
                Add(1, 1, MAXN, l, h, h + 1);
                Inc(1, 1, MAXN, l, h, -1);
            }
            else if(ch == 'C')
            {
                int l, h, val;
                cin >> l >> h >> val;
                Ass(1, 1, MAXN, l, h, val);
            }
            else
            {
                int l, h;
                cin >> l >> h;
                cout << Query(1, 1, MAXN, l, h) << "\n";
            }
        }
    }
    return 0;
}
