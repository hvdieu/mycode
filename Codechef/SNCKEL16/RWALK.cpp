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
#include <set>
#include <sstream>
#include <stack>
#include <string>
#include <thread>
#include <tuple>
#include <typeindex>
#include <unordered_set>
#include <utility>
#include <vector>
#include <regex>

constexpr int N = 510;

bool mark[N * N];

int solve(const std::vector<int>& steps, bool vertical) {
    int n = (int) steps.size();
    std::memset(mark, 0, sizeof(mark));
    mark[0] = true;
    int sum = 0;
    for (int s : steps) {
        for (int j = sum; j >= 0; --j) {
            if (mark[j]) {
                mark[j + s] = true;
            }
        }
        sum += s;
    }

    int best = 1e9;
    for (int i = 0; i <= sum; ++i) {
        if (mark[i]) {
            best = std::min(best, std::abs(sum - i - i));
        }
    }

    return best;
}

int main() {
//    std::freopen("/Volumes/Setup/Android/projects/mep/mepcpp/mepcpp/in", "r", stdin);
//    std::freopen("/Volumes/Setup/Android/projects/mep/mepcpp/mepcpp/out", "w", stdout);
    freopen("in.txt", "r", stdin);
    int tn;
    std::cin >> tn;
    while (tn--) {
        int n;
        std::cin >> n;

        std::vector<int> x, y;
        for (int i = 1; i <= n + 1; ++i) {
            int a;
            std::cin >> a;
            if (i < n + 1) {
                std::string f;
                std::cin >> f;
            }
            if (i % 2 == 1) {
                x.push_back(a);
            } else {
                y.push_back(a);
            }
        }

        auto answer = solve(x, true) + solve(y, false);
        std::cout << answer << '\n';
        //std::cout << x.size() << ' ' << y.size() << "\n";
    }
}
