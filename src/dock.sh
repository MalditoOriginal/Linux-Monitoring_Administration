#!/bin/bash

# Build docker image
docker build -t projects .

# Run docker container
docker run -itdp 3000:3000 -v "$(dirname "$(pwd)"):/projects" projects