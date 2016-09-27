#include <iostream>
#include <fstream>
#include <algorithm>
using namespace std;
const string NAME = "hipercijevi";
const string INP = "in";
const string OUT = "out";
const string CHARSET = "1234567890abcdpf";
const int MAXEXT = 5;
int cnt = 0;

int Exist(string s)
{
    ifstream fin(s.c_str());
    return fin.is_open();
}

void Dfs(string ext, int pos)
{
    if(Exist(NAME + "." + INP + "." + ext) && Exist(NAME + "." + OUT + "." + ext))
    {
        system(("md " + NAME + "\\Test" + ext).c_str());
        system(("copy " + NAME + "." + INP + "." + ext + " " + NAME + "\\Test" + ext + "\\" + NAME + ".inp").c_str());
        system(("copy " + NAME + "." + OUT + "." + ext + " " + NAME + "\\Test" + ext + "\\" + NAME + ".out").c_str());
    }
    if(pos > MAXEXT)
    {
        return;
    }
    for(int i = 0; i < CHARSET.size(); i++)
    {
        Dfs(ext + CHARSET[i], pos + 1);
    }
}

int main()
{
    Dfs("", 1);
}
