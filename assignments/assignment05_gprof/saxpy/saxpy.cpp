#include <iostream>
#include <string>
#include <vector>

void saxy(const uint64_t n, const float& a, const std::vector<float>& x, std::vector<float>& y) {
    for (uint64_t i = 0; i < n; ++i) {
        y[i] = a*x[i] + y[i];
    }
}

int main() {
    uint64_t n = 1<<20;
    std::vector<float> x(n, 1.0);
    std::vector<float> y(n, 1.0);
    
    saxy(1<<20, 2.0, x, y);
    
    return 0;
}

