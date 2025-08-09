# Static `socat-builder` Build for Linux (amd64)

This repository provides a Docker-based workflow for compiling a **static** `socat` binary for **Linux/amd64**.  
It uses Alpine Linux and BuildKit to produce a portable binary that can be copied directly to your host.

## 📦 Features
- **Static build** (`LDFLAGS=-static`)
- Cross-platform build using Docker `--platform` (works on ARM, x86_64 hosts, etc.)
- Direct binary export to the host via Docker BuildKit (`--output`)
- Based on `socat` version **1.7.3.2** with custom patches

## 🛠 Requirements
- Docker 18.09+ (with BuildKit enabled)
- Internet connection to download dependencies

## ⚡ Quick Build

```bash
# Enable BuildKit and build for Linux/amd64
DOCKER_BUILDKIT=1 docker build \
    --platform linux/amd64 \
    --output type=local,dest=./out .
