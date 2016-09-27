#include<bits/stdc++.h>
using namespace std;

main(){
    ios_base::sync_with_stdio(false);
    int n,m;
    string s;
    int t;
    cin>>t;
    while(t--){
        cin>>n>>m>>s;
        printf("%d ",n);
        for(int i=0;i<s.size();i++){
            for(int j=0;j<m;j++){
                putchar(s[i]);
            }
        }
        puts("");
    }
}
