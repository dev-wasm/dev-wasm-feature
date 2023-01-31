#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "libxml2-installed" dpkg-query -l libxml2-dev

# Report result
reportResults