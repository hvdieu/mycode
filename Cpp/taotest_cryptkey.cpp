
#include <bits/stdc++.h>
using namespace std;
#define length(x) (int)x.size()
const double pi=acos(-1);

long long a[100000], maxm;
int maxn, base;

long long gcd(long long a, long long b)
{
    if (a % b == 0) return b;
    return gcd(b, a%b);
}

long long lcm(long long a, long long b)
{
    long long c = gcd(a, b);
    c = a / c;
    if (c<=maxm/b) c = c * b; else c = maxm*10;
    return c;
}

void solve(int n, int kt)
{
    cout<<n<<endl;
    for(int i=1; i<=n; i++)
    {
        a[i] = rand()*rand() % maxm + 1;
        cout<<a[i]<<' ';
    }
    cout<<endl;
    if (kt==0)
    {
        long long k = rand()*rand() % maxm + 1;
        cout<<k<<endl; return;
    }
    long long k = 1;
    for(int i=1; i<=100; i++)
    {
        int sl = 0; long long res = 1;
        for(int j=1; j<=n; j++)
        {
            int x = rand() * rand() * 30121995;
            if (x % base > 0)
            {
                sl++;
                if (sl==1) res = a[j]; else
                if (gcd(a[j], res)!=1) res = gcd(a[j], res);
            }
        }
        if (lcm(k, res)<=maxm) k = lcm(k, res);
    }
    cout<<k<<endl;
}

int main()
{
    freopen("input.inp","r",stdin);
    freopen("CRYPTKEY.INP","w",stdout);
    cin>>maxn>>maxm;
    int test;      cin>>test;
    cout<<test<<endl;
    if (maxn<=10) base = 2; else base = 4;
    while (test--)
    {
        int kt; cin>>kt;
        int n = rand()*rand() % (maxn-4) + 5;
        solve(n, kt);
    }
    return 0;
}
