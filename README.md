# dev-wasm-feature
A feature for devcontainers that installs wasmtime and the wasi-sdk and language runtimes.

Currently supports:
* C/C++
* Rust

More languages coming soon.

## Examples

### Basic installation of the wasi-sdk and wasmtime
```json
{
    "name": "C/C++ WASM",
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "remoteEnv": {
  	    "PATH": "${containerEnv:PATH}:/usr/local/lib/wasi-sdk-17.0/bin"
    },
    "features": {
        "devwasm.azurecr.io/dev-wasm/dev-wasm-feature/wasmtime-wasi:0.0.4": {
            "version": "17"
        }
    },
    "customizations": {
        "vscode": {
	          "extensions": [ "ms-vscode.cpptools-extension-pack" ]
	      }
    }
}
```

### Wasmtime + Rust
```json
{
    "name": "Rust WASM",
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "remoteEnv": {
	"PATH": "${containerEnv:PATH}:/usr/local/lib/wasi-sdk-17.0/bin"
    },
    "features": {
        "devwasm.azurecr.io/dev-wasm/dev-wasm-feature/wasmtime-wasi:0.0.4": {
            "version": "17"
        },
        "ghcr.io/devcontainers/features/rust": {},
	"devwasm.azurecr.io/dev-wasm/dev-wasm-feature/rust-wasi:0.0.1": {}
    },
    "customizations": {
	"vscode": {
		"extensions": [
			"ms-vscode.cpptools"
		]
    }
}
```

