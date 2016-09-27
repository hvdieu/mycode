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
struct node
{
    long long mx, cnt;
};
const int MAXX = 1000000, MAXY = 1000000;
int nTest, n;
vector<pair<pair<int, int>, int> > vIn[MAXX * 2 + 9], vOut[MAXX * 2 + 9];
long long ans1, ans2, lz[(1 << 22) + 9];
node it[(1 << 22) + 9];

void Build(int x, int low, int high)
{
    it[x] = (node){0, high - low + 1};
    lz[x] = 0;
    if(low == high)
    {
        return;
    }
    int mid = (low + high) / 2;
    Build(x * 2, low, mid);
    Build(x * 2 + 1, mid + 1, high);
}

void Down(int x)
{
    it[x * 2].mx += lz[x];
    lz[x * 2] += lz[x];
    it[x * 2 + 1].mx += lz[x];
    lz[x * 2 + 1] += lz[x];
    lz[x] = 0;
}

node Combine(node a, node b)
{
    if(a.mx > b.mx)
    {
        return a;
    }
    if(a.mx < b.mx)
    {
        return b;
    }
    return (node){a.mx, a.cnt + b.cnt};
}

void Update(int x, int low, int high, int l, int h, long long val)
{
    if(low > h || high < l)
    {
        return;
    }
    if(low >= l && high <= h)
    {
        it[x].mx += val;
        lz[x] += val;
        return;
    }
    Down(x);
    int mid = (low + high) / 2;
    Update(x * 2, low, mid, l, h, val);
    Update(x * 2 + 1, mid + 1, high, l, h, val);
    it[x] = Combine(it[x * 2], it[x * 2 + 1]);
}

int main()
{
    //ifstream cin("rectland.inp");
    //ofstream cout("rectland.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++)
    {
        cin >> n;
        fill(vIn, vIn + MAXX * 2 + 2, vector<pair<pair<int, int>, int> >());
        fill(vOut, vOut + MAXX * 2 + 2, vector<pair<pair<int, int>, int> >());
        for(int i = 1; i <= n; i++)
        {
            int x, y, xx, yy, val;
            cin >> x >> y >> xx >> yy >> val;
            vIn[x + 1 + MAXX].push_back(make_pair(make_pair(y + 1 + MAXY, yy + MAXY), val));
            vOut[xx + MAXX].push_back(make_pair(make_pair(y + 1 + MAXY, yy + MAXY), val));
        }
        Build(1, 0, MAXY * 2 + 1);
        ans1 = -1;
        ans2 = 0;
        for(int i = 0; i <= MAXX * 2 + 1; i++)
        {
            for(int j = 0; j < vIn[i].size(); j++)
            {
                Update(1, 0, MAXY * 2 + 1, vIn[i][j].first.first, vIn[i][j].first.second, vIn[i][j].second);
            }
            if(it[1].mx > ans1)
            {
                ans1 = it[1].mx;
                ans2 = 0;
            }
            if(it[1].mx == ans1)
            {
                ans2 += it[1].cnt;
            }
            for(int j = 0; j < vOut[i].size(); j++)
            {
                Update(1, 0, MAXY * 2 + 1, vOut[i][j].first.first, vOut[i][j].first.second, -vOut[i][j].second);
            }
        }
        cout << ans1 << " " << ans2 << "\n";
    }
    return 0;
}