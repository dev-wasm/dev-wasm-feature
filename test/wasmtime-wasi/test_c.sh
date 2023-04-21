#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

cat << EOF > hello.c
#include <stdio.h>

int main() {
    printf("Hello devcontainers from C\n");
}
EOF

# Definition specific tests
check "compiles" /usr/local/lib/wasi-sdk-20.0/bin/clang -o hello.wasm hello.c
check "runs" wasmtime hello.wasm | grep "Hello devcontainers from C"

# Report result
reportResults
