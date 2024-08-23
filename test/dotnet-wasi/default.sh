#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

mkdir hello
cat << EOF > hello/hello.cs
using System.IO;
using System;

class Test {
    static void Main(String[] args) {
        Console.WriteLine("Hello Dotnet!");
    }  
}
EOF

cat << EOF > hello/hello.csproj
<Project Sdk="Microsoft.NET.Sdk">
    <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <RuntimeIdentifier>wasi-wasm</RuntimeIdentifier>
    <OutputType>Exe</OutputType>
    <PublishTrimmed>true</PublishTrimmed>
    <WasmSingleFileBundle>true</WasmSingleFileBundle>
  </PropertyGroup>
  </Project>
EOF

# Definition specific tests
check "installs" dotnet workload install wasi-experimental
check "compiles" dotnet build hello
# TODO: Renable this
# check "runs" wasmtime hello/bin/Debug/net8.0/wasi-wasm/hello.wasm | grep "Hello Dotnet!"

# Report result
reportResults