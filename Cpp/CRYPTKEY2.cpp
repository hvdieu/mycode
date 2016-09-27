#include <bits/stdc++.h>
using namespace std;
#define length(x) (int)x.size()
const double pi=acos(-1);

long long a[100000], b[1000];
int n, m;
long long k;

void analysis(long long k)
{
    long long i = 2;
    m = 0;
    while (k>0)
    {
        while (i*i<=k  && k%i!=0) i++;
        if (i*i>k)
        {
            m++; b[m] = k; break;
        }
        m++; b[m] = 1;
        while (k % i == 0)
        {
            b[m] = b[m] * i;  k /= i;
        }
    }
    if (m==0)
    {
        m++; b[m] = 1;
    }
}

long long gcd(long long a, long long b)
{
    if (a % b == 0) return b;
    return gcd(b, a % b);
}

bool solve()
{
    cin>>n;
    for(int i=1; i<=n; i++) cin>>a[i];
    cin>>k;
    analysis(k);
    for(int i=1; i<=m; i++)
    {
        int sl = 0;
        long long res = 2 * k;
        for(int j=1; j<=n; j++)
            if (a[j] % b[i] == 0)
        {
            sl++;
            if (sl==1) res = a[j]; else res = gcd(res, a[j]);
        }
        if (k % res != 0) return false;
    }
    return true;
}

int main()
{
    freopen("CRYPTKEY.INP","r",stdin);
    freopen("CRYPTKEY.OUT","w",stdout);
    int test;   cin>>test;
    while (test--)
        if (solve()) cout<<"YES"<<endl; else cout<<"NO"<<endl;
    return 0;
}
