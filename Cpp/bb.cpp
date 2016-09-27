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
const int MAXN = 8, COE = 47, MD = 1000000007;
int n, a[MAXN + 9], point[MAXN + 9], nWin, win, cache[9][5000009], szC[9], used[9];
long long ans;
vector<pair<int, int> > v1, v2;
int h1[5000009], h2[5000009], sz1, sz2;

int Hash(int point[])
{
    int res = 0;
    for(int i = 1; i <= n; i++)
    {
        res = ((long long)res * COE + point[i] + 1) % MD;
    }
    return res;
}

void Dfs1(int pos)
{
    if(pos >= v1.size())
    {
        h1[sz1] = Hash(point);
        sz1++;
        return;
    }
    int x = v1[pos].first, y = v1[pos].second;

        win++;
        point[x] += 3;
        Dfs1(pos + 1);
        point[x] -= 3;
        win--;

        win++;
        point[y] += 3;
        Dfs1(pos + 1);
        point[y] -= 3;
        win--;

        point[x]++;
        point[y]++;
        Dfs1(pos + 1);
        point[x]--;
        point[y]--;
}

void Dfs2(int pos)
{
    if(pos >= v2.size())
    {
        h2[sz2] = Hash(point);
        sz2++;
        return;
    }
    int x = v2[pos].first, y = v2[pos].second;
    if(point[x] - 3 >= 0 && win + 1 <= nWin)
    {
        win++;
        point[x] -= 3;
        Dfs2(pos + 1);
        point[x] += 3;
        win--;
    }
    if(point[y] - 3 >= 0 && win + 1 <= nWin)
    {
        win++;
        point[y] -= 3;
        Dfs2(pos + 1);
        point[y] += 3;
        win--;
    }
    if(point[x] - 1 >= 0 && point[y] - 1 >= 0)
    {
        point[x]--;
        point[y]--;
        Dfs2(pos + 1);
        point[x]++;
        point[y]++;
    }
}

int main()
{
    //ifstream cin("bb.inp");
    //ofstream cout("bb.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    int iTest = 0;
    while(cin >> n)
    {
        iTest++;
        if(!n)
        {
            break;
        }
        for(int i = 1; i <= n; i++)
        {
            cin >> a[i];
        }
        int sum = 0;
        for(int i = 1; i <= n; i++)
        {
            sum += a[i];
        }
        nWin = sum - n * (n - 1);
        if(nWin < 0 || nWin > n * (n - 1) / 2)
        {
            cout << "Case #" << iTest << ": OK!\n";
            continue;
        }
        v1.clear();
        v2.clear();
        for(int i = 1; i <= n; i++)
        {
            for(int j = i + 1; j <= n; j++)
            {
                v1.push_back(make_pair(i, j));
            }
        }
        int mid = v1.size() / 2;
        for(int rep = 1; rep <= mid; rep++)
        {
            v2.push_back(v1.back());
            v1.pop_back();
        }
        sz1 = 0;
        sz2 = 0;
        if(!used[n])
        {
            fill(point, point + n + 1, 0);
            Dfs1(0);
            szC[n] = sz1;
            copy(h1, h1 + sz1, cache[n]);
            used[n] = 1;
        }
        else
        {
            sz1 = szC[n];
            copy(cache[n], cache[n] + szC[n], h1);
        }
        copy(a + 1, a + n + 1, point + 1);
        win = 0;
        Dfs2(0);
        sort(h1, h1 + sz1);
        ans = 0;
        for(int i = 0; i < sz2; i++)
        {
            ans += upper_bound(h1, h1 + sz1, h2[i]) - lower_bound(h1, h1 + sz1, h2[i]);
        }
        cout << "Case #" << iTest << ": " << ans << "\n";
    }
    return 0;
}
