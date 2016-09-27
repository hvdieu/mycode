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
struct point
{
    int x, y;
};
const int MAXN = 100000, MAXX = 1000, MAXY = 1000, oo = 1000000009;
int n, ans, par[MAXN + 9], used[MAXN + 9], dist[MAXN + 9];
point a[MAXN + 9];
vector<int> v1[MAXX + MAXY + 9], v2[MAXX + MAXY + 9];
vector<pair<int, pair<int, int> > > vEdge;
pair<int, int> itX[(1 << 11) + 9], itY[(1 << 11) + 9];

void MakeSet(int x)
{
    par[x] = x;
}

int FindSet(int x)
{
    if(par[x] != x)
    {
        par[x] = FindSet(par[x]);
    }
    return par[x];
}

void UnionSet(int x, int y)
{
    x = FindSet(x);
    y = FindSet(y);
    if(x == y)
    {
        return;
    }
    par[x] = y;
}

void Build(pair<int, int> it[], int x, int low, int high, int tp)
{
    if(!tp)
    {
        it[x] = make_pair(oo, 0);
    }
    else
    {
        it[x] = make_pair(-oo, 0);
    }
    if(low == high)
    {
        return;
    }
    int mid = (low + high) / 2;
    Build(it, x * 2, low, mid, tp);
    Build(it, x * 2 + 1, low, mid, tp);
}

void Update(pair<int, int> it[], int x, int low, int high, int pos, pair<int, int> val, int tp)
{
    if(low > pos || high < pos)
    {
        return;
    }
    if(low == high)
    {
        it[x] = val;
        return;
    }
    int mid = (low + high) / 2;
    Update(it, x * 2, low, mid, pos, val, tp);
    Update(it, x * 2 + 1, mid + 1, high, pos, val, tp);
    if(!tp)
    {
        it[x] = min(it[x * 2], it[x * 2 + 1]);
    }
    else
    {
        it[x] = max(it[x * 2], it[x * 2 + 1]);
    }
}

pair<int, int> Query(pair<int, int> it[], int x, int low, int high, int l, int h, int tp)
{
    if(low > h || high < l)
    {
        if(!tp)
        {
            return make_pair(oo, 0);
        }
        else
        {
            return make_pair(-oo, 0);
        }
    }
    if(low >= l && high <= h)
    {
        return it[x];
    }
    int mid = (low + high) / 2;
    if(!tp)
    {
        return min(Query(it, x * 2, low, mid, l, h, tp), Query(it, x * 2 + 1, mid + 1, high, l, h, tp));
    }
    else
    {
        return max(Query(it, x * 2, low, mid, l, h, tp), Query(it, x * 2 + 1, mid + 1, high, l, h, tp));
    }
}

int CmpX(int x, int y)
{
    return a[x].x < a[y].x;
}

int main()
{
    //ifstream cin("d.inp");
    //ofstream cout("d.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    cin >> n;
    for(int i = 1; i <= n; i++)
    {
        cin >> a[i].x >> a[i].y;
        v1[a[i].x + a[i].y].push_back(i);
        v2[a[i].x - a[i].y + MAXY].push_back(i);
    }
    Build(itX, 1, 0, MAXX, 1);
    Build(itY, 1, 0, MAXY, 1);
    for(int val = 0; val <= MAXX + MAXY; val++)
    {
        for(int i = 0; i < v1[val].size(); i++)
        {
            int id = v1[val][i];
            pair<int, int> tmp = Query(itX, 1, 0, MAXX, a[id].x, MAXX, 1);
            if(tmp.second)
            {
                vEdge.push_back(make_pair(a[id].y - a[id].x - tmp.first, make_pair(id, tmp.second)));
            }
                           tmp = Query(itY, 1, 0, MAXY, a[id].y, MAXY, 1);
            if(tmp.second)
            {
                vEdge.push_back(make_pair(a[id].x - a[id].y - tmp.first, make_pair(id, tmp.second)));
            }
            Update(itX, 1, 0, MAXX, a[id].x, make_pair(a[id].y - a[id].x, id), 1);
            Update(itY, 1, 0, MAXY, a[id].y, make_pair(a[id].x - a[id].y, id), 1);
        }
    }
    Build(itX, 1, 0, MAXX, 1);
    Build(itY, 1, 0, MAXY, 1);
    for(int val = MAXX + MAXY; val >= 0; val--)
    {
        for(int i = 0; i < v1[val].size(); i++)
        {
            int id = v1[val][i];
            pair<int, int> tmp = Query(itX, 1, 0, MAXX, 0, a[id].x, 1);
            if(tmp.second)
            {
                vEdge.push_back(make_pair(a[id].x - a[id].y - tmp.first, make_pair(id, tmp.second)));
            }
                           tmp = Query(itY, 1, 0, MAXY, 0, a[id].y, 1);
            if(tmp.second)
            {
                vEdge.push_back(make_pair(a[id].y - a[id].x - tmp.first, make_pair(id, tmp.second)));
            }
            Update(itX, 1, 0, MAXX, a[id].x, make_pair(a[id].x - a[id].y, id), 1);
            Update(itY, 1, 0, MAXY, a[id].y, make_pair(a[id].y - a[id].x, id), 1);
        }
    }
    Build(itX, 1, 0, MAXX, 1);
    Build(itY, 1, 0, MAXY, 1);
    for(int val = 0; val <= MAXX + MAXY; val++)
    {
        for(int i = 0; i < v2[val].size(); i++)
        {
            int id = v2[val][i];
            pair<int, int> tmp = Query(itX, 1, 0, MAXX, a[id].x, MAXX, 1);
            if(tmp.second)
            {
                vEdge.push_back(make_pair(-a[id].x - a[id].y - tmp.first, make_pair(id, tmp.second)));
            }
                           tmp = Query(itY, 1, 0, MAXY, 0, a[id].y, 1);
            if(tmp.second)
            {
                vEdge.push_back(make_pair(a[id].x + a[id].y - tmp.first, make_pair(id, tmp.second)));
            }
            Update(itX, 1, 0, MAXX, a[id].x, make_pair(-a[id].x - a[id].y, id), 1);
            Update(itY, 1, 0, MAXY, a[id].y, make_pair(a[id].x + a[id].y, id), 1);
        }
    }
    Build(itX, 1, 0, MAXX, 1);
    Build(itY, 1, 0, MAXY, 1);
    for(int val = MAXX + MAXY; val >= 0; val--)
    {
        for(int i = 0; i < v2[val].size(); i++)
        {
            int id = v2[val][i];
            pair<int, int> tmp = Query(itX, 1, 0, MAXX, 0, a[id].x, 1);
            if(tmp.second)
            {
                vEdge.push_back(make_pair(a[id].x + a[id].y - tmp.first, make_pair(id, tmp.second)));
            }
                           tmp = Query(itY, 1, 0, MAXY, a[id].y, MAXY, 1);
            if(tmp.second)
            {
                vEdge.push_back(make_pair(-a[id].x - a[id].y - tmp.first, make_pair(id, tmp.second)));
            }
            Update(itX, 1, 0, MAXX, a[id].x, make_pair(a[id].x + a[id].y, id), 1);
            Update(itY, 1, 0, MAXY, a[id].y, make_pair(-a[id].x - a[id].y, id), 1);
        }
    }
    for(int val = 0; val <= MAXX + MAXY; val++)
    {
        sort(v1[val].begin(), v1[val].end(), CmpX);
        sort(v2[val].begin(), v2[val].end(), CmpX);
        for(int i = 0; i + 1 < v1[val].size(); i++)
        {
            int x = v1[val][i], y = v1[val][i + 1];
            vEdge.push_back(make_pair(abs(a[x].x - a[y].x) + abs(a[x].y - a[y].y), make_pair(x, y)));
        }
        for(int i = 0; i + 1 < v2[val].size(); i++)
        {
            int x = v2[val][i], y = v2[val][i + 1];
            vEdge.push_back(make_pair(abs(a[x].x - a[y].x) + abs(a[x].y - a[y].y), make_pair(x, y)));
        }
    }
    sort(vEdge.begin(), vEdge.end());
    ans = 0;
    for(int i = 1; i <= n; i++)
    {
        MakeSet(i);
    }
    for(int i = 0; i < vEdge.size(); i++)
    {
        int z = vEdge[i].first, x = vEdge[i].second.first, y = vEdge[i].second.second;
        if(FindSet(x) != FindSet(y))
        {
            ans += z;
            UnionSet(x, y);
        }
    }
    cout << ans << "\n";
    return 0;
}
