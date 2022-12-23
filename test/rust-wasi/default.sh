#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

cat << EOF > hello.rs
fn main() {
    println!("Hello rust world!");
}
EOF

# Definition specific tests
check "compiles" rustc --target wasm32-wasi hello.rs
check "runs" wasmtime hello.wasm | grep "Hello rust world!"

# Report result
reportResults