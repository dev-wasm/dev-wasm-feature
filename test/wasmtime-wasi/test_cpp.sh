#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

cat << EOF > hello.cpp
#include <iostream>
#include <fstream>

class WasmWasi {
    public:
        WasmWasi() {}

        void print()
        {
            std::cout << "Hello C++ World!" << std::endl;
        }
};

int main(int argc, char** argv)
{
    WasmWasi w;
    w.print();
}
EOF

# Definition specific tests
check "compiles" /usr/local/lib/wasi-sdk-24.0-x86_64-linux/bin/clang++ -o hello.wasm hello.cpp
check "runs" wasmtime hello.wasm | grep "Hello C++ World!"

# Report result
reportResults
