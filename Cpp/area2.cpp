#include <iostream>
#include <stdio.h>
#include <algorithm>
using namespace std;
#define mn 20001
#define mt 131071
typedef struct{
int num,val;
} data;
typedef struct{
int x1,x2,y;

bool io;
} vertex;
data d[mt];
vertex a[mn];
int n;
inline void update(int k,int first,int last,int u,int v,bool is_open){
if (first>v||last<u) return ;
int n1=k<<1,n2=1+(k<<1);
if (first>=u&&last<=v){
if (is_open){
if (!(d[k].num++)) d[k].val=last-first;
}
else{
if (!(--d[k].num)) d[k].val=d[n1].val+d[n2].val;
}
return ;
}
int mid=(first+last)>>1;
if (first<mid){
update(n1,first,mid,u,v,is_open);
update(n2,mid,last,u,v,is_open);
if (!(d[k].num)) d[k].val=d[n1].val+d[n2].val;
}
}
bool cmp(vertex u,vertex v){
if (u.y<v.y) return(true);
return(false);
}
inline void cal(){
int area=0;
for(int i=1;i<(n<<1);i++){
update(1,0,30000,a[i].x1,a[i].x2,a[i].io);
area+=(a[i+1].y-a[i].y)*d[1].val;
}
printf("%d",area);
}
int main(){
freopen("AREA.INP","r",stdin);
freopen("AREA.OU1","w",stdout);
scanf("%d",&n);
for(int i=1;i<=n;i++){
scanf("%d%d%d%d",&a[i].x1,&a[i].y,&a[i].x2,&a[i+n].y);
a[i+n].x1=a[i].x1;a[i+n].x2=a[i].x2;
a[i].io=true;a[i+n].io=false;
}
sort(a+1,a+1+(n<<1),cmp);
cal();
}

