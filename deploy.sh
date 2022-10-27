#!/bin/bash

docker build --no-cache -t perlt/workspace . && docker push perlt/workspace