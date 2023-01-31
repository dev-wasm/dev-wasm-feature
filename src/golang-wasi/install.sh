#!/bin/bash
set -e

TINY_GO_VERSION="${VERSION:-"0.26.0"}"

# Maybe install curl
which curl > /dev/null || (apt update && apt install curl -y -qq)

curl https://github.com/tinygo-org/tinygo/releases/download/v${TINY_GO_VERSION}/tinygo_${TINY_GO_VERSION}_amd64.deb -L --output tinygo_${TINY_GO_VERSION}_amd64.deb && \
    dpkg -i tinygo_${TINY_GO_VERSION}_amd64.deb && \
    rm tinygo_${TINY_GO_VERSION}_amd64.deb