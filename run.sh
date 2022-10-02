#!/bin/bash
if [[ "$OSTYPE" == "msys"* ]]; then
  docker run -v /var/run/docker.sock:/var/run/docker.sock -it arch-workspace bash
else
  docker run -v //var/run/docker.sock:/var/run/docker.sock -it arch-workspace bash
fi
