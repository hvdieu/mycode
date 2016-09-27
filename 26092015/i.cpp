#include <iostream>
#include <fstream>
#include <algorithm>
using namespace std;
const int MAXN = 8, MAXM = 10000;
int nTest, n, m, k, r, a[MAXN + 9], fl[MAXM + 9], tbl[MAXM + 9][MAXN + 9], nxt[MAXM + 9][MAXN + 9], per[MAXN + 9], q, e[MAXN + 9];
string ans;

int Check()
{
    int time = 1;
    for(int i = 1; i <= n; i++)
    {
        int pos = per[i];
        if(tbl[time][pos] < e[pos])
        {
            if(!nxt[time][pos])
            {
                time = m + 1;
            }
            else
            {
                time = nxt[time][pos];
            }
        }
        if(time + k - 1 > m)
        {
            return 0;
        }
        time += k;
    }
    return 1;
}

int main()
{
    //ifstream cin("i.inp");
    //ofstream cout("i.out");
    ios_base::sync_with_stdio(0);
    cin.tie(NULL);
    cin >> nTest;
    for(int iTest = 1; iTest <= nTest; iTest++)
    {
        cin >> n >> m >> k >> r;
        for(int i = 1; i <= n; i++)
        {
            cin >> a[i];
        }
        for(int i = 1; i <= m; i++)
        {
            cin >> fl[i];
        }
        for(int i = 1; i <= m; i++)
        {
            copy(tbl[i - 1], tbl[i - 1] + n + 1, tbl[i]);
            for(int j = 1; j <= n; j++)
            {
                tbl[i][j] = max(0, tbl[i][j] - r);
            }
            tbl[i][fl[i]] = a[fl[i]];
        }
        fill(nxt[m + 1], nxt[m + 1] + n + 1, 0);
        for(int i = m; i >= 1; i--)
        {
            copy(nxt[i + 1], nxt[i + 1] + n + 1, nxt[i]);
            nxt[i][fl[i]] = i;
        }
        cin >> q;
        for(int iQ = 1; iQ <= q; iQ++)
        {
            for(int i = 1; i <= n; i++)
            {
                cin >> e[i];
            }
            for(int i = 1; i <= n; i++)
            {
                per[i] = i;
            }
            ans = "No";
            while(1)
            {
                if(Check())
                {
                    ans = "Yes";
                    break;
                }
                if(!next_permutation(per + 1, per + n + 1))
                {
                    break;
                }
            }
            cout << ans << "\n";
        }
    }
    return 0;
}
