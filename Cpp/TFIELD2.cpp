#include <bits/stdc++.h>
#define MAX_N 1000+1

using namespace std;

int  N,K;
double S[MAX_N];
int Color[MAX_N],Num[MAX_N];
double Res;
vector<pair<double, int> > X;

double Area(int X1, int Y1, int X2, int Y2, int X3, int Y3) {
    double A=(double(Y1)-double(Y2));
    double B=(double(X2)-double(X1));
    double C=-double(X1)*A-double(Y1)*B;
    double Dis=abs(A*double(X3)+B*double(Y3)+C)/(sqrt(A*A+B*B));
    double Res=Dis*(sqrt(A*A+B*B))/2;
    return Res;
}

double Find(int Pos) {
    double Cres=0;
    int Cmax=0;
    memset(Num,0,sizeof(Num));
    for (int i=Pos; i<=N; i++) {
        Num[Color[i]]++;
        Cmax=max(Cmax,Num[Color[i]]);
        if (i-Pos+1-Cmax<=K) {
            Cres=max(Cres,S[i]-S[Pos-1]);
        }
    }
    return Cres;
}

int main() {
    freopen("TFIELD.Inp","r",stdin);
    freopen("TFIELD.Out","w",stdout);
    cin >> N >> K;
    for (int i=1; i<=N; i++) {
        int M;
        int A[MAX_N],B[MAX_N];
        cin >> M >> Color[i];
        for (int j=1; j<=M; j++) {
            cin >> A[j] >> B[j];
        }
        if (M<3) {
            S[i]=0;
        } else {
            for (int j=3; j<=M; j++) {
                S[i]+=Area(A[1],B[1],A[j-1],B[j-1],A[j],B[j]);
            }
        }
        X.push_back(make_pair(S[i],Color[i]));
    }
    sort(X.begin(),X.end());
    for (int i=0; i<int(X.size()); i++) {
        S[i+1]=X[i].first;
        Color[i+1]=X[i].second;
    }
    Res=0;
    for (int i=1; i<=N; i++) {
        Res=max(Res,Find(i));
    }
    printf("%0.1lf",Res);
    return 0;
}
