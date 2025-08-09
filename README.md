# Static `socat` Build for Linux (amd64)

This repository provides a Docker-based workflow for compiling a **static** `socat` binary for **Linux/amd64**.  
It uses Alpine Linux and Docker to produce a portable binary that can be copied directly to your host.  
Custom patches are applied to `xio-ip4.c` and `xio-proxy.c` before compilation.

## 📦 Features
- **Static build** (`LDFLAGS=-static`) for maximum portability
- Cross-platform builds using Docker `--platform` (works on ARM, x86_64 hosts, etc.)
- Automatic export of compiled binary to host machine
- Includes custom patched source files
- Cleanup of old build containers/images before building
- Simple one-command build via `run.sh`

## 🛠 Requirements
- Docker 18.09+ (BuildKit optional, not required for `run.sh`)
- Internet connection to download build dependencies
- Bash shell to run the helper script

## ⚡ Recommended Build Method

The easiest way to build is by running the provided `run.sh` script:

```bash
./run.sh
````

This script will:

1. Stop and remove any previous `build-socat-container` container
2. Remove the old `build-socat` image if it exists
3. Build a fresh Docker image for `linux/amd64`
4. Run the build inside a container
5. Copy the resulting `socat` binary to the current directory (`./socat`)

**Note:** This method ensures a clean rebuild every time.

### `run.sh` Content

```bash
#!/bin/bash
docker stop build-socat-container && docker rm build-socat-container

if [ $? == 0 ]
then
    image=$(docker image ls | grep build-socat | awk '{print $3}')
    docker rmi $image
fi

docker build --platform linux/amd64 -t socat-builder . && \
docker run --rm --platform linux/amd64 -v ./:/out socat-builder sh -c "/build-socat.sh && cp /tmp/socat-1.7.3.2/socat /out/"
```

## 🖥 Manual Build Methods

### Using Docker BuildKit `--output`

```bash
DOCKER_BUILDKIT=1 docker build \
    --platform linux/amd64 \
    --output type=local,dest=./ .
```

After completion, the compiled binary will be available at:

```
./socat
```

### Running the Build Inside a Container (no cleanup)

```bash
docker build --platform linux/amd64 -t socat-builder .
docker run --rm --platform linux/amd64 \
    -v ./:/out \
    socat-builder \
    sh -c "/build-socat.sh && cp /tmp/socat-1.7.3.2/socat /out/"
```

## 📂 Repository Structure

```
.
├── build-socat.sh       # Script to configure and compile socat (static build)
├── Dockerfile           # Build environment definition
├── run.sh               # Recommended helper script (with cleanup + build)
├── socat-1.7.3.2.tar.gz # Original socat source code archive
├── xio-ip4.c            # Custom patched source file
├── xio-proxy.c          # Custom patched source file
└── README.md
```

## 📜 License

`socat` is licensed under the [GPL v2](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html).
This repository contains build scripts and patches and is provided **as-is** without warranty.

```

If you save this as `README.md`, it will fully document:
- Your project purpose
- How to use `run.sh`
- The script contents
- Alternative build methods
- Repository file structure
- License info

```
