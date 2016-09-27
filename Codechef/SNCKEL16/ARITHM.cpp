//
//  fox.cpp
//  mepcpp
//
//  Created by Zinge on 5/28/16.
//  Copyright © 2016 MEP. All rights reserved.
//

#include <algorithm>
#include <atomic>
#include <array>
#include <cassert>
#include <cstring>
#include <fstream>
#include <functional>
#include <iomanip>
#include <iostream>
#include <map>
#include <memory>
#include <queue>
#include <sstream>
#include <stack>
#include <string>
#include <thread>
#include <tuple>
#include <typeindex>
#include <utility>
#include <vector>
#include <regex>

long long gcd(long long u, long long v) {
    while (v != 0) {
        auto r = u % v;
        u = v;
        v = r;
    }
    return u;
}

/// a * out_x + b * out_y = out_g
void euclid(long long a, long long b,
            long long& out_g, long long& out_x, long long& out_y) {
    long long x = 1, y = 0, x1 = 0, y1 = 1, t;
    while (b) {
        auto q = a / b;
        t = x;
        x = x1;
        x1 = t - q * x1;
        t = y;
        y = y1;
        y1 = t - q * y1;
        t = b;
        b = a - q * b;
        a = t;
    }
    if (a > 0) {
        out_g = a;
        out_x = x;
        out_y = y;
    } else {
        out_g = -a;
        out_x = -x;
        out_y = -y;
    }
}

int main() {
//    std::freopen("/Volumes/Setup/Android/projects/mep/mepcpp/mepcpp/in", "r", stdin);
//    std::freopen("/Volumes/Setup/Android/projects/mep/mepcpp/mepcpp/out", "w", stdout);
    int tn;
    std::cin >> tn;
    while (tn--) {
        int n;
        long long c;
        std::cin >> n >> c;

        bool possible = false;

        if (n == 1) {
            possible = (n == c);
        } else {
            long long a = n;
            long long b = (long long) n * (n - 1) / 2;

            auto g = gcd(a, b);

            if (c % g == 0) {
                a /= g;
                b /= g;
                c /= g;
                long long out_g, out_x, out_y;
                euclid(a, b, out_g, out_x, out_y);
                assert(out_g == 1);
                assert(a * out_x + b * out_y == 1);
                out_x *= c;
                out_y *= c;
                assert(a * out_x + b * out_y == c);

                auto k = -out_x / b;
                out_x = out_x + k * b;

                while (out_x - b > 0) {
                    out_x = out_x - b;
                    --k;
                }
                while (out_x <= 0) {
                    out_x = out_x + b;
                    ++k;
                }
                assert(out_x > 0);
                assert(out_x - b <= 0);

                out_y = out_y - k * a;
                possible = (out_y > 0);
            }
        }

        std::cout << (possible ? "Yes" : "No") << '\n';
    }
}
