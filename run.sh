#!/bin/bash
docker stop build-socat-container && docker rm build-socat-container

	if [ $? == 0 ]
	then
	image=$(docker image ls | grep build-socat | awk '{print $3}')
	docker rmi $image
	fi

docker build --platform linux/amd64 -t socat-builder . && \
docker run --rm --platform linux/amd64 -v ./:/out socat-builder sh -c "/build-socat.sh && cp /tmp/socat-1.7.3.2/socat /out/"
