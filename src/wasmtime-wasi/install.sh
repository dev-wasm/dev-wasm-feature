#!/usr/bin/env bash
set -e

WASI_VERSION="${VERSION:-"20"}"
WASI_VERSION_FULL="${WASI_VERSION}.0"
WIT_VERSION="${WIT_VERSION:-"0.4.0"}"
WASMTIME_VERSION="${WASMTIME_VERSION:-"v9.0.4"}"
WASM_TOOLS_VERSION="${WASM_TOOLS_VERSION:-"1.0.54"}"
WASI_LOCATION="${LOCATION:-"/usr/local"}/lib"

# TODO: Support Windows someday?
FILE="wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz"

# Maybe install curl
which curl > /dev/null || (apt update -y && apt install curl -y -qq)

# Maybe install xz
which xz > /dev/null || (apt update -y && apt install xz-utils -y -qq)

apt install -y -qq libc6

# Install wasmtime
INSTALLER=./wasmtime-install.sh
curl https://wasmtime.dev/install.sh -L --output ${INSTALLER}
chmod a+x ${INSTALLER}
${INSTALLER} --version ${WASMTIME_VERSION}
cp ${HOME}/.wasmtime/bin/wasmtime /usr/bin/wasmtime

# Install wasi-sdk
curl https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_VERSION}/${FILE} -L --output ${FILE}

# Install to location
tar -C ${WASI_LOCATION} -xvf ${FILE}
rm ${FILE}

# Install wit-bindgen
curl https://github.com/bytecodealliance/wit-bindgen/releases/download/wit-bindgen-cli-${WIT_VERSION}/wit-bindgen-v${WIT_VERSION}-x86_64-linux.tar.gz -L --output wit-bindgen-v${WIT_VERSION}-x86_64-linux.tar.gz

# Install to location
tar -xvzf wit-bindgen-v${WIT_VERSION}-x86_64-linux.tar.gz
cp wit-bindgen-v${WIT_VERSION}-x86_64-linux/wit-bindgen ${LOCATION}/bin/wit-bindgen
rm -r wit-bindgen-v${WIT_VERSION}-x86_64-linux*

# Install wasm-tools
curl https://github.com/bytecodealliance/wasm-tools/releases/download/wasm-tools-${WASM_TOOLS_VERSION}/wasm-tools-${WASM_TOOLS_VERSION}-x86_64-linux.tar.gz -L --output wasm-tools-${WASM_TOOLS_VERSION}-x86_64-linux.tar.gz

# Install to location
tar -xvzf wasm-tools-${WASM_TOOLS_VERSION}-x86_64-linux.tar.gz
cp wasm-tools-${WASM_TOOLS_VERSION}-x86_64-linux/wasm-tools ${LOCATION}/bin/wasm-tools
rm -r wasm-tools-${WASM_TOOLS_VERSION}-x86_64-linux*

# Install lighttpd for web serving
DEBIAN_FRONTEND=noninteractive TZ=America/Los_Angeles apt install -y -qq lighttpd
