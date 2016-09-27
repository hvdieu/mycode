#include <bits/stdc++.h>
#define FOR(i, a, b) for(int i = (a); i < (b); ++i)
#define REP(i, a, b) for(int i = (a); i <=(b); ++i)
#define REPD(i, a, b) for(int i = (a); i >= (b); --i)
#define TR(i, a) for(typeof(a.begin()) i = a.begin(); i != a.end(); ++i)
#define SZ(a) (int(a.size()))
#define ALL(a) a.begin(), a.end()
#define long long long
#define II pair<int, int>
#define X first
#define Y second
#define MP make_pair
#define PB push_back
#define RESET(a, v) memset(a, v, sizeof(a))
#define endl '\n'

const char shiftOff[4][10] = {
    {'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'},
    {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';'},
    {'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/'},
    {'0', '0', ' ', ' ', ' ', ' ', ' ', ' ', '0', '0'},
};

const char shiftOn[4][10] = {
    {'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'},
    {'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':'},
    {'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?'},
    {'0', '0', ' ', ' ', ' ', ' ', ' ', ' ', '0', '0'},
};

const int N = 111;
const int dx[] = {-1, -2, -2, -1, 1, 2, 2, 1};
const int dy[] = {-2, -1, 1, 2, 2, 1, -1, -2};

using namespace std;

string s;
bool was[10][10][10][10][N];

struct node {
    II pos[2]; int at;
    node (II a, II b, int p) {
        pos[0] = a; pos[1] = b; at = p;
    }
};

bool isShift(char c) {return c == '0';}

void push(queue<node> &Q, node a) {
    if (a.pos[0] == a.pos[1]) return;
    if (!was[a.pos[0].X][a.pos[0].Y][a.pos[1].X][a.pos[1].Y][a.at]) {
        was[a.pos[0].X][a.pos[0].Y][a.pos[1].X][a.pos[1].Y][a.at] = 1;
        Q.push(a);
    }
}

bool outside(int x, int y) {
    return x < 0 || y < 0 || x > 3 || y > 9;
}

int main() {
    ios :: sync_with_stdio(0); cin.tie(0);
    //freopen("J.in", "r", stdin);
    while (getline(cin, s)) {
        if (s == "*") break;
        RESET(was, 0);
        queue<node> Q;
        Q.push(node(MP(3, 0), MP(3, 9), 0));
        was[3][0][3][9][0] = 1;
        bool ok = 0;
        while (!Q.empty()) {
            node u = Q.front(); Q.pop();
            if (u.at == SZ(s)) {
                ok = 1; break;
            }
            //cout << u.pos[0].X << ' ' << u.pos[0].Y << ' ' << u.pos[1].X << ' ' << u.pos[1].Y << ' ' << u.at << ' ' << s[u.at] << endl;
            FOR(i, 0, 8) {
                int x = u.pos[0].X + dx[i];
                int y = u.pos[0].Y + dy[i];
                if (outside(x, y)) continue;
                if (isShift(shiftOff[x][y]))
                    push(Q, node(MP(x, y), u.pos[1], u.at));
                else {
                    char nextChar;
                    if (isShift(shiftOff[u.pos[1].X][u.pos[1].Y]))
                        nextChar = shiftOn[x][y];
                    else
                        nextChar = shiftOff[x][y];
                    if (nextChar == s[u.at])
                        push(Q, node(MP(x, y), u.pos[1], u.at + 1));
                }
            }
            FOR(i, 0, 8) {
                int x = u.pos[1].X + dx[i];
                int y = u.pos[1].Y + dy[i];
                if (outside(x, y)) continue;
                if (isShift(shiftOff[x][y]))
                    push(Q, node(u.pos[0], MP(x, y), u.at));
                else {
                    char nextChar;
                    if (isShift(shiftOff[u.pos[0].X][u.pos[0].Y]))
                        nextChar = shiftOn[x][y];
                    else
                        nextChar = shiftOff[x][y];
                    if (nextChar == s[u.at])
                        push(Q, node(u.pos[0], MP(x, y), u.at + 1));
                }
            }
        }
        cout << int(ok) << endl;
    }
    return 0;
}
