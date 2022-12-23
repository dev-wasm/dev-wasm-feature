#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "version" wasmtime --version
check "if wasi-sdk exists" ls /usr/local/lib/wasi-sdk-16.0
check "clang" /usr/local/lib/wasi-sdk-16.0/bin/clang --version | grep wasi

# Report result
reportResults