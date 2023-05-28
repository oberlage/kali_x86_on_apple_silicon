# Kali x86 on Apple Silicon (M1-Mx) via Docker emulation
When running `arm64` Kali on Apple Silicon you may lack some functionality, for instance running x86 compiled ELF executables or cross-compiling with `mingw-w64`.
By using Docker you can emulate `x86` and run a minimal version of the `x86` Kali command line version.

## Pre-requisites
- [Docker installed on your Mac](https://docs.docker.com/desktop/install/mac-install/)
- A `Public` folder in your (host OS) user's home folder to mount to (this should exist already)

## Basic x86 Kali on Apple Silicon
Please see `./Dockerfile`. 
This container image is based on the empty Kali without the metapackage installed. 
Some basic packages are installed in the container (like `ping`, `nano` and `mingw-w64`).

```bash
# Build the conatiner from ./Dockerfile
docker build -t kalix86 .

# Run the container and open an interactive terminal in the Kali guest OS
#   -v      run it by mounting host ~/Public (Mac) to guest (Kali) /usr/public
#   -ti     open an interactive terminal with bash
docker run -v ~/Public:/usr/public -ti kalix86 bash

# Please note: you Mac's ~/Public (user Public folder) is mapped to /usr/public in Kali for read/write
#  this makes exchanging files easy
```

# Frequently Asked Questions
## Can I connect to an OpenVPN network from the Docker container?
Possibly, yes. But so far I did not get this working. The container is missing priviliges to create the tunnel network interface, I tried specifying specific capabilities with Docker `--cap-add` and `--priviliged` parameters, but to no avail.

## Will this give me a full running Kali with Desktop?
No. It's only the command line version of Kali, and the metapackage is missing, so it's not the standard 'batteries included' version of Kali.

## What is this useful for?
You can compile binaries for x86 from you Apple Silicon ARM processor, when running the following command from the Docker container:
```bash
x86_64-w64-mingw32-gcc some_code.c -o x86_binary.exe
```

## What is installed in the package?
Check out the `Dockerfile` in this repo to see what's happening.