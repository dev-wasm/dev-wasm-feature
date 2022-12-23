#!/usr/bin/env bash
set -e

WASI_VERSION="${VERSION:-"17"}"
WASI_VERSION_FULL="${WASI_VERSION}.0"
WASI_LOCATION=${LOCATION:-"/usr/local/lib"}

# TODO: Support Windows someday?
FILE="wasi-sdk-${WASI_VERSION_FULL}-linux.tar.gz"

# Maybe install curl
which curl > /dev/null || (apt update && apt install curl -y -qq)

# Install wasmtime
curl https://wasmtime.dev/install.sh -sSf | bash

echo https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_VERSION}/${FILE}

# Install wasi-sdk
curl https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_VERSION}/${FILE} -L --output ${FILE}

# Install to location
tar -C ${WASI_LOCATION} -xvf ${FILE}
rm ${FILE}