#include <stdio.h>
#include <iostream>
#include <algorithm>
#include <math.h>
#include <vector>
#include <string>
#include <cstring>
#include <map>
#include <set>
#define For(i,a,b) for(int i=a;i<=b;i++)
#define Ford(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define N 30010
using namespace std;
struct node {
    node *left,*right,*cha;
    int key,k1,k2;
};
int n,q,a[N];
node *t[N],*nilt;

void init() {
    nilt = new node();
    nilt->left=nilt; nilt->right=nilt; nilt->cha=nilt;
    nilt->k1=0; nilt->k2=0; nilt->key=0;
    For(i,1,n) t[i]=nilt;
}

void tao(node* &i,int x) {
    i = new node();
    i->cha=nilt; i->left=nilt; i->right=nilt;
    i->k2=1; i->key=x; i->k1=1;
}

void cnt(node* i, node* j, bool ok) {
    j->cha=i;
    if (ok) i->left=j; else i->right=j;
}

void cc(node* i) {
    i->k2 = i->left->k2 + i->right->k2+ i->k1;
}

void uptree(node* i) {
    node *p,*pp,*j;
    p=i->cha; pp=p->cha;
    if (p->left==i) {
        j=i->right;
        cnt(i,p,false);
        cnt(p,j,true);
    } else {
        j=i->left;
        cnt(i,p,true);
        cnt(p,j,false);
    }
    cnt(pp,i,pp->left==p);
    cc(p); cc(i);
}

void splay(node* i) {
    node *p,*pp;
    while (i->cha!=nilt) {
        p=i->cha; pp=p->cha;
        if (pp!=nilt) {
            if ((pp->left==p) == (p->left==i)) uptree(p);
                else uptree(i);
        }
        uptree(i);
    }
}

node* find(node* root,int u){
    node* i=root;
    while (1){
        if (i->key==u) return i;
        if (i->key>u) {
            if (i->left==nilt) return i;
            i=i->left;
        } else {
            if (i->right==nilt) return i;
            i=i->right;
        }
    }
}

void Insert(node* &root,int u,int x) {
    node* j; tao(j,u);
    if (root==nilt) {
        root=j;
        return;
    }
    node* i=find(root,u);
    if (i->key!=u) {
        if (i->key>u) cnt(i,j,true); else cnt(i,j,false);
        while (i->cha!=nilt) {
            cc(i);
            i=i->cha;
        }
    } else {
        i->k1 += x;
        j=i;
        while (i->cha!=nilt) {
            cc(i); i=i->cha;
        }
    }
   // splay(j); root=j;
}

void update(int i,int j,int x) {
    int jj;
    while (i<=n) {
        Insert(t[i],j,x);
        i += i&(-i);
    }
}

int sum(node* &root, int u) {
    node* i; int s=0;
    node* j;
    i=root;
    while (1) {
        if (i==nilt) break;
        if (i->key<=u) s+= i->k1;
        if (i->key<=u) {
            s+=i->left->k2;
            j=i; i=i->right;
        } else {
            j=i; i=i->left;
        }
    }
   // splay(j); root=j;
    return s;
}

int get(int i,int j) {
    int res=0;
    while (i) {
        res += sum(t[i],j);
        i -= i&(-i);
    }
    return res;
}

int main() {
    freopen("INPUT.TXT","r",stdin);
    freopen("KQUERY2.OUT","w",stdout);
    scanf("%d",&n);
    init();
    For(i,1,n) {
        int x;
        scanf("%d",&x);
        update(i,x,1); a[i]=x;
    }
    scanf("%d",&q);
    while (q) {
        q--;
        int kind,i,j,u;
        scanf("%d",&kind);
        if (kind==0) {
            scanf("%d%d\n",&i,&u);
            update(i,a[i],-1);
            update(i,u,1); a[i]=u;
        } else {
            scanf("%d%d%d\n",&i,&j,&u);
            printf("%d\n",(j-i+1)-(get(j,u)-get(i-1,u)));
        }
    }
}

