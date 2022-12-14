#!/bin/bash

if [ -z "$DOCKER_IMAGE_TAG" ];
then
	DOCKER_IMAGE_TAG=$(cat docker_image_tag)
fi

docker run --name "$DOCKER_IMAGE_TAG"-instance \
	--volume $(pwd)/share:/home/builder/share \
	--volume ${HOME}/.ssh:/home/builder/.ssh \
	--volume ${HOME}/.docker:/home/builder/.docker \
	--volume /lib/modules:/lib/modules \
	--volume /usr/src:/usr/src \
	--rm \
	--cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
	-it "$DOCKER_IMAGE_TAG" \
	/bin/bash
