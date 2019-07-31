#!/usr/bin/env bash

# Build image and add a descriptive tag
sudo docker build . -t boston_houseprices_inference

# List docker images
sudo docker image ls

# Run flask app
sudo docker run -p 8000:80 boston_houseprices_inference

