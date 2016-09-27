#include <bits/stdc++.h>
#define pp pair<int,int>
using namespace std;
int n,t,ans;
pp p[1001];
int main()
{
    freopen("vcat.inp","r",stdin);
    freopen("vcat.out", "w", stdout);
    cin>>n>>t;
    int x,y;
    for (int i=1;i<=n;i++){
        cin>>x>>y;
        p[i]=make_pair(x,y);
    }
    sort(p+1,p+1+n);
    bool dd=false;
    int en=-(1e9);
    for (int i=1;i<=n;i++){
        int d=p[i].first-t,c=p[i].first+t;
        if (dd==false){
            if (en>=d) d=en+1;
            int cc=d+p[i].second-1;
            if (cc>c){
                en=c;
                dd=true;
                ans++;
            }else{
                en=cc;
                dd=false;
            }
        } else{
            if (en>=d) continue;
            int cc=d+p[i].second-1;
            if (cc>c){
                en=c;
                dd=true;
                ans++;
            }else{
                en=cc;
                dd=false;
            }
        }
    }
    cout<<ans;
}
