#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

cat << EOF > hello.go
package main

import "fmt"

func main() {
    fmt.Println("Hello Go!")
}
EOF

# Definition specific tests
check "compiles" tinygo build -target=wasip1 -o hello.wasm hello.go
check "runs" wasmtime hello.wasm | grep "Hello Go!"

# Report result
reportResults