#include <bits/stdc++.h>

using namespace std;
typedef pair<int, int> ii;
typedef pair<long long, int> lli;
typedef long long ll;
typedef unsigned long long ull;

#define For(i,a,b) for(int i=a;i<=b;i++)
#define Rep(i,a,b) for(int i=a;i>=b;i--)
#define fi first
#define se second
#define pb push_back
#define sz(s) int(s.size())
#define reset(f,x) memset(f,x,sizeof(f))
#define all(x) x.begin(), x.end()
#define N 11
#define eps 0.0000000001

long double c[N][N];
double kq[N*N];
double res[N*N];
long double x[N*N], a[N*N][N*N], b[N*N][N*N];
int vt[N*N];
int m, n, k, pt;

int id(int i, int j) {
    return (i-1) * n + j;
}

int main() {
    freopen("input.txt","r",stdin);
    //freopen("anar.out","w",stdout);
    int dem = 0;
    while (1) {
        scanf("%d %d %d", &n, &m, &k);
        if (!n) break; dem++;
        if (dem > 1) cout << endl << endl;
        pt = 0;
        For(i, 1, m) For(j, 1, n) {
            scanf("%Lf", &c[i][j]);
        }
        For(i, 1, m) For(j, 1, n) {
            int cnt = 0; pt++;
            For(x, 1, m) For(y, 1, n) if (abs(x-i) + abs(y-j) <= k) {
                cnt++; a[pt][id(x,y)] = 1;
            } else a[pt][id(x,y)] = 0;
            a[pt][m*n+1] = c[i][j] * cnt;
        }
        For(i, 1, m*n) vt[i] = i;
        For(i, 1, pt) {
            if (abs(a[i][i]) <= eps) {
                For(k, i+1, m*n) if (abs(a[i][k]) > eps) {
                    For(t, 1, pt) swap(a[t][i], a[t][k]);
                    swap(vt[i], vt[k]);
                    break;
                }
            }
            For(j, i + 1, pt) if (abs(a[j][i]) > eps) {
            	long double hs = a[i][i] / a[j][i];
                For(k, i, m*n+1) a[j][k] = a[j][k] * hs - a[i][k];
            }
        }

        Rep(i, pt, 1) {
            long double sum = 0;
            Rep(j, m*n, i+1) sum += a[i][j] * x[j];
            x[i] = (a[i][m*n+1] - sum) / a[i][i];
            res[vt[i]] = x[i];
        }

        For(i, 1, m * n) {
            int x = trunc(res[i]);
            int len = 0;
            if (!x) len = 1;
            if (x) while (x) {
                len++; x /= 10;
            }
            For(j, 1, 8-3-len) cout << ' ';
            double y = (double)res[i];
            printf("%.2lf", y);
            if (i < m * n && i % n == 0) cout << endl;
        }

        /*For(i, 1, pt) {
            double sum = 0;
            For(j, 1, m*n) sum += a[i][j] * kq[j];
            printf("%.2lf\n", sum - a[i][m*n+1]);
        }
        printf("%.2Lf", a[11][10]);*/
    }
}


