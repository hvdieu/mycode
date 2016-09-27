#include <bits/stdc++.h>

using namespace std;

const string NAME = "MFUNC";
const int MAX = 1000000000;

string to_string(int a) {
    string s;
    while (a) {
        s.push_back(char((a % 10) + '0'));
        a /= 10;
    }
    reverse(s.begin(), s.end());
    return s;
}

long long Rand(long long l, long long h)
{
    return l + ((long long)rand() * (RAND_MAX + 1) * (RAND_MAX + 1) * (RAND_MAX + 1) +
                (long long)rand() * (RAND_MAX + 1) * (RAND_MAX + 1) +
                (long long)rand() * (RAND_MAX + 1) +
                rand()) % (h - l + 1);
}

int main() {
    srand(time(NULL));
    int ntest = 100000;
    for(int iTest = 1; iTest <= 100; iTest++) {
        string test = to_string(iTest);
        system(("md Test" + test).c_str());
        ofstream inp((NAME + ".inp").c_str());
        inp << ntest << endl;
        int D, A;
        long long L, R;
        for(int j = 1; j <= ntest; j++) {
            if (iTest <= 15) {
                D = Rand(0, 100);
                A = Rand(1, MAX);
                R = Rand(1, 100);
                L = Rand(1, R);
            } else if (iTest <= 25) {
                 D = Rand(0, MAX);
                 A = Rand(1, MAX);
                 R = Rand(1, 1000000);
                 L = Rand(1, R);
            } else {
                D = Rand(0, MAX);
                A = Rand(1, MAX);
                R = Rand(1, (long long)MAX * MAX);
                L = Rand(1, R);
            }
            inp << A << ' ' << D << ' ' << L << ' ' << R << endl;
            inp.close();
            system((NAME + ".exe").c_str());
            system(("move " + NAME + ".inp Test" + test + "\\" + NAME + ".inp").c_str());
            system(("move " + NAME + ".out Test" + test + "\\" + NAME + ".out").c_str());
        }
    }
}
