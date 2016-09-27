#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#include <queue>
#include <stack>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define ld long double
#define pb push_back
#define sz(s) int(s.size())
#define inf 1000000007
#define N 100010

struct node {
    node *ll,*rr,*cha;
    int k1,k2,k3;
};

int x[N],y[N],n;
vector<ii> qx,qy;
node *t[N],*nilt;;

inline void roirac() {
    sort(qx.begin(),qx.end());
    sort(qy.begin(),qy.end());
    int d1 = 0,d2 = 0;
    For(i,1,n) {
        if (qx[i].fi != qx[i-1].fi) d1++;
        x[qx[i].se] = d1;
        if (qy[i].fi != qy[i-1].fi) d2++;
        y[qy[i].se] = d2;
    }
}

inline void cnt(node* i, node* j,bool ok) {
    j->cha = i;
    if (ok) i->ll = j; else i->rr = j;
}


inline void init() {
    nilt = new node();
    nilt->ll = nilt; nilt->rr = nilt; nilt->cha = nilt;
    nilt->k1 = 0; nilt->k2 = 0; nilt->k3 = 0;
    For(i,1,n) t[i] = nilt;
}

inline void tao(node* &i,int x ,int y) {
    i = new node();
    i->ll = nilt; i->rr = nilt; i->cha=nilt;
    i->k1 = x; i->k2 = y; i->k3 = y;
}

inline void cc(node* i) {
    i->k3 = max(max(i->ll->k3,i->rr->k3),i->k2);
}

void uptree(node* i) {
    node *p,*pp,*j;
    p = i->cha; pp = p->cha;
    if (p->ll == i) {
        j = i->rr;
        cnt(i,p,false);
        cnt(p,j,true);
    } else {
        j = i->ll;
        cnt(i,p,true);
        cnt(p,j,false);
    }
    cnt(pp,i,pp->ll == p);
    cc(p);
	cc(i);
}

node* splay(node* i) {
    node *p, *pp;
    while (i->cha != nilt) {
        p = i->cha; pp = p->cha;
        if (pp != nilt) {
        if ((pp->ll == p) == (p->ll == i)) uptree(p);
            else uptree(i);
   		}
        uptree(i);
    }
    return i;
}

inline void Ups(node* i) {
	if (i==nilt) return;
    node* j = i;
    while (i != nilt) {
        cc(i);
        i = i->cha;
    }
 //   return splay(j);
}

inline void Insert(node* &root, int x, int y) {
    node* j; tao(j,x,y);
    node* i = root;
    if (root==nilt) {
        root = j;
        return;
    }
    while (1) {
    	if (i->k1 == x) {
    		if (i->k2 < j->k2) {
                i->k2 = j->k2;
                Ups(i);
    		}
    		return;
    	}
        if (i->k1 >= x) {
            if (i->ll != nilt) i = i->ll; else {
                cnt(i,j,true);
                if (i->k3 < j->k3) Ups(i);
                return;
            }
        } else {
            if (i->rr != nilt) i = i->rr; else {
                cnt(i,j,false);
                if (i->k3 < j->k3) Ups(i);
                return;
            }
        }
    }
}

inline void update(int i,int j,int val) {
    while (i <= n) {
        Insert(t[i],j,val);
        i +=  i & (-i);
    }
}

inline int GetMax(node* &root, int x) {
    node* i = root;
    node* j = root;
    int res = 0;
    if (root==nilt) return 0;
    while (1) {
        if (i==nilt) break;
        if (i->k1 <= x) res = max(res,i->k2);
        if (i->k1 <= x) {
            res = max(res,i->ll->k3);
            j = i;
            i = i->rr;
        } else {
        	j = i;
        	i = i->ll;
    	}
    }
   // root = splay(j);
    return res;
}

inline int get(int i,int j) {
    int res = 0;
    while (i) {
        res = max(res,GetMax(t[i],j));
        i -= i & (-i);
    }
    return res;
}

void solve() {
    roirac();
    init();
    //For(i,1,n) cout << x[i] << ' ';
    //cout << "\n";
    //For(i,1,n) cout << y[i] << ' ';
    //cout << "\n";
    int kq = 0;
    For(i,1,n) {
        int t = 0;
        t = max(t,get(x[i]-1,y[i]-1)+1);
        kq = max(kq,t);
        if (kq > 90) {
            cout << 103;
            return;
        }
        update(x[i],y[i],t);
    }
    cout << kq;
}

int main() {
 //   freopen("LIS2VN.INP","r",stdin);
 //   freopen("LIS2VN.OUT","w",stdout);
    scanf("%d",&n);
    qx.pb(ii(-inf,0)); qy.pb(ii(-inf,0));
    For(i,1,n) {
        scanf("%d%d",&x[i],&y[i]);
        qx.pb(ii(x[i],i)); qy.pb(ii(y[i],i));
    }
    solve();
}

