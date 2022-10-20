#!/bin/bash
if [[ "$OSTYPE" == "msys"* ]]; then
	echo "Running on windows"
	docker run -v //var/run/docker.sock:/var/run/docker.sock -it arch-workspace bash
else
	echo "Running on linux"
	docker run -v /var/run/docker.sock:/var/run/docker.sock -it arch-workspace bash
fi
