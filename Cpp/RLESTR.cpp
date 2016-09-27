#include <bits/stdc++.h>

using namespace std;
typedef pair<char, long long> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef deque< pair<char, ll> > deq;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define FOR(i, f) for(__typeof(f.begin()) i = f.begin(); i != f.end(); i++)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f, x) memset(f, x, sizeof(f))
#define all(x) x.begin(), x.end()
#define two(x) (1LL << x)
#define bit(x, i) ((x >> i) & 1LL)
#define onbit(x, i) (x | (1LL << i))
#define N 1010

char a[N], b[N];
int n, ntest;
deq s1, s2, s3, s4, s;

deq tach(char s[]) {
    deq tmp; tmp.clear();
    int n = strlen(s+1);
    ll num = 0; ll mu = 1;
    Rep(i, n, 1) if (s[i] >= 'a' && s[i] <= 'z') tmp.push_front(ii(s[i], num)), num = 0, mu = 1;
    else num = mu*(int(s[i]) - int('0')) + num, mu *= 10;
    return tmp;
}

void inkq(deq s1) {
    For(j, 0, sz(s1)-1) printf("%c%lld", s1[j].fi, s1[j].se);
    printf("\n");
}

deq join(deq s1, deq s2) {
    For(j, 0, sz(s2)-1) {
        s1.push_back(s2[j]);
        int n = sz(s1) - 1;
        if (n && s1[n].fi == s1[n-1].fi) s1[n-1].se += s1[n].se, s1.pop_back();
    }
    return s1;
}

void cut(deq s, ll x, deq &s1, deq &s2) {
    s1.clear(); s2.clear();
    ll sum = 0; int i;
    for(i = 0; i < sz(s); i++) {
        if (s[i].se <= x) s1.push_back(s[i]), x -= s[i].se;
        else break;
    }
    if (x) {
        s1.push_back(ii(s[i].fi, x));
        s2.push_back(ii(s[i].fi, s[i].se - x));
        i++;
    }
    for(i; i < sz(s); i++) s2.push_back(s[i]);
}

int main() {
    //ios_base::sync_with_stdio(false);
   // freopen("rlestr.inp","r",stdin);
   // freopen("rlestr.out","w",stdout);
    char c1, c2;
    while (scanf("%c%c\n", &c1, &c2) != -1) {
    	ntest++;
        printf("%c%c: ", c1, c2);
        if (c2 == '1') {
            scanf("%s\n", a+1); scanf("%s\n", b+1);
            s1 = tach(a); s2 = tach(b);
            //inkq(s1); inkq(s2);
            s1 = join(s1, s2);
            inkq(s1);
        } else if (c2 == '2') {
            scanf("%s\n", a+1);
            ll l, r; scanf("%lld%lld\n", &l, &r);
            r = r + l - 1;
            s = tach(a);
            cut(s, r, s2, s3);
            //inkq(s2); inkq(s3);
            cut(s2, l-1, s1, s2);
            //inkq(s1); inkq(s2); inkq(s3);
            s = join(s1, s3);
            inkq(s);
        } else if (c2 == '3') {
            scanf("%s\n", a+1);
            ll l, r;
            s = tach(a);
            scanf("%lld%lld\n", &l, &r);
            r = r + l - 1;
            cut(s, r, s2, s3);
            cut(s2, l-1, s1, s2);
            inkq(s2);
        } else {
            scanf("%s\n", a+1); scanf("%s\n", b+1);
            ll p; scanf("%lld\n", &p);
            s = tach(a); s2 = tach(b);
            cut(s, p-1, s1, s3);
            s = join(s1, s2);
            s = join(s, s3);
            inkq(s);
        }
    }
}
