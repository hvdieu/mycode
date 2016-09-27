#include <bits/stdc++.h>
#include <string>

using namespace std;

const string NAME = "ZQUERY";

string to_string(int a) {
    string s;
    while (a) {
        s.push_back(char((a % 10) + '0'));
        a /= 10;
    }
    reverse(s.begin(), s.end());
    return s;
}

int main() {
    srand(time(NULL));
    for(int i = 1; i <= 10; i++) {
        string iTest = to_string(i);
        system(("mkdir Test" + iTest).c_str());
        cout << iTest << endl;
        system(("copy " + NAME + "_" + iTest + ".in" + "Test" + iTest + "\ZQUERY.INP").c_str());
      //  system(("ren \Test" + iTest + "\\" + NAME + "_" + iTest + ".in ZQUERY.INP").c_str());
    }
}
