#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "version" wasmtime --version
check "if wasi-sdk exists" ls /usr/local/lib/wasi-sdk-23.0-x86_64-linux
check "clang" /usr/local/lib/wasi-sdk-23.0-x86_64-linux/bin/clang --version | grep wasi

# Report result
reportResults