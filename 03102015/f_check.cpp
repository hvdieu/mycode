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
const string NAME = "f";
const int NTEST = 100, MAXT = 10, MAXN = 1000, MAXQ = 1000, MINX = -100000, MAXX = 100000;
int t, q;

long long Rand(long long l, long long h)
{
    return l + ((long long)rand() * (RAND_MAX + 1) * (RAND_MAX + 1) * (RAND_MAX + 1) +
                (long long)rand() * (RAND_MAX + 1) * (RAND_MAX + 1) +
                (long long)rand() * (RAND_MAX + 1) +
                rand()) % (h - l + 1);
}

int Fc(string s1, string s2)
{
    ifstream f1(s1.c_str()), f2(s2.c_str());
    string s, t;
    while(getline(f1, s))
    {
        if(!getline(f2, t))
        {
            return 0;
        }
        if(s != t)
        {
            return 0;
        }
    }
    if(getline(f2, t))
    {
        return 0;
    }
    return 1;
}

int Check(string file)
{
    system((NAME + "_trau.exe").c_str());
    return Fc(file, NAME + ".ans");
}

int main()
{
    srand(time(NULL));
    for(int iTest = 1; iTest <= NTEST; iTest++)
    {
        ofstream inp((NAME + ".inp").c_str());
        t = Rand(1, MAXT);
        inp << t << "\n";
        for(int iT = 1; iT <= t; iT++)
        {
            q = Rand(1, MAXQ);
            inp << q << "\n";
            for(int iQ = 1; iQ <= q; iQ++)
            {
                int tp = Rand(0, 3), l = Rand(1, MAXN), h = Rand(1, MAXN), val = Rand(-MINX, MAXX);
                if(l > h)
                {
                    swap(l, h);
                }
                if(!tp)
                {
                    inp << "A " << l << " " << h << "\n";
                }
                else if(tp == 1)
                {
                    inp << "B " << l << " " << h << "\n";
                }
                else if(tp == 2)
                {
                    inp << "C " << l << " " << h << " " << val << "\n";
                }
                else
                {
                    inp << "S " << l << " " << h << "\n";
                }
            }
        }
        inp.close();
        system((NAME + ".exe").c_str());
        if(!Check(NAME + ".out"))
        {
            cout << "Test " << iTest << ": WRONG!\n";
            return 0;
        }
        cout << "Test " << iTest << ": CORRECT!\n";
    }
    return 0;
}
