#!/bin/bash

docker login && docker build --no-cache -t perlt/workspace . && docker push perlt/workspace
