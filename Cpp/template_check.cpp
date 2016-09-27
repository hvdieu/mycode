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
const string NAME = "template";
const int NTEST = 100;

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
