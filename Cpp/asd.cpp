#include <iostream>
#include <vector>
using namespace std;

vector<bool> f1,f2;
string s1,s2;


int main()
{
    int t;
    for (int i=0;i<=25;i++)
        f1.push_back(0);
    for (int i=0;i<=25;i++)
        f2.push_back(0);
    bool ok;
    cin>>t;
    int k=0;
    for (int i=1;i<=t;i++)
    {
        cin>>s1;
        cin>>s2;
        k++;
        cout<<k<<endl;
        for (int j=0;j<s1.length();j++)
        {
            //cout<<int(s1[j])-97<<" "<<int(s2[j])-97<<endl;
            f1[int(s1[j])-97]=k;
            f1[0]=k;
            cout<<f1[0]<<endl;
            cout<<f1[int(s1[j])-97]<<endl;
        }
        for (int j=0;j<26;j++) cout<<f1[j]<<" ";cout<<endl;
        for (int j=0;j<s2.length();j++) f2[int(s2[j])-97]=k;
        for (int j=0;j<26;j++) cout<<f2[j]<<" ";cout<<endl;
        ok=false;
        for (int j=0;j<=25;j++)
        {
            if ((k==f2[j])&&(f1[j]==k))
            {
                ok=true;
                break;
            }
        }
        if (ok) {cout<<"Yes"<<endl;} else {cout<<"No"<<endl;};
    }
    return 0;
}

