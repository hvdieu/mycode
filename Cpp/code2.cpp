#include<bits/stdc++.h>
#define MAX   1000100
#define FOR(i,a,b) for (int i=(a),_b=(b);i<=_b;i=i+1)
#define REP(i,n) for (int i=0,_n=(n);i<_n;i=i+1)
using namespace std;
int s[MAX],t[MAX];
int prevS[MAX],prevT[MAX];
int lenS,lenT;
int kmp[MAX];
void readString(int &len,int s[],int prev[]) {
	string input;
	map<string,int> prevApp;
	while (cin>>input && input!="$") {
		len++;
		__typeof(prevApp.begin()) it=prevApp.find(input);
		if (it==prevApp.end()) {
			s[len]=prevApp.size()+1;
			prev[len]=0;
		} else {
			s[len]=s[it->second];
			prev[len]=it->second;
		}
		prevApp[input]=len;
	}
	FOR(i,1,len) printf("%d ",s[i]); printf("\n");
	/*printf("String length: %d\n",len);
	FOR(i,1,len) printf("Char %d is %d, previous %d\n",i,s[i],prev[i]);*/
}
bool match(int prev[],int pos,int len) {
	if (pos<len) return (false);
	if (len>lenT) return (false);
	if (len==1) return (true);
	if (prevT[len]==0) return (prev[pos]<pos-len+1);
	else return (pos-prev[pos]==len-prevT[len]);
}
void KMP(void) {
	int j=kmp[1]=0;
	FOR(i,2,lenT) {
		while (j>0 && !match(prevT,i,j+1)) j=kmp[j];
		if (match(prevT,i,j+1)) j++;
		kmp[i]=j;
	}
	j=0;
	//FOR(i, 1, lenT) cout << kmp[i] << ' '; cout << endl;
	FOR(i,1,lenS) {
		while (j>0 && !match(prevS,i,j+1)) j=kmp[j];
		if (match(prevS,i,j+1)) j++;
		if (j==lenT) {
			printf("%d\n",i-lenT+1);
			return;
		}
	}
	printf("-1\n");
}
int main(void) {
	ios::sync_with_stdio(false);
	freopen("input.txt", "r", stdin);
	freopen("output.txt", "w", stdout);
	readString(lenS,s,prevS);
	readString(lenT,t,prevT);
	KMP();
	return 0;
}
