#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

mkdir hello
cat << EOF > hello/hello.cs
using System.IO;
class Test {
    static void Main(String[] args) {
        Console.WriteLine("Hello Dotnet!");
    }  
}
EOF

cat << EOF > hello/hello.csproj
<Project Sdk="Microsoft.NET.Sdk">
    <PropertyGroup>
      <OutputType>Exe</OutputType>
      <TargetFramework>net7.0</TargetFramework>
      <ImplicitUsings>enable</ImplicitUsings>
      <Nullable>enable</Nullable>
      <WasiTrim>true</WasiTrim>
    </PropertyGroup>  
    <ItemGroup>
      <PackageReference Include="Wasi.Sdk" Version="0.1.3-preview.10012" />
    </ItemGroup>
  </Project>
EOF

# Definition specific tests
check "compiles" dotnet build hello
check "runs" wasmtime hello/bin/Debug/net7.0/hello.wasm | grep "Hello Dotnet!"

# Report result
reportResults