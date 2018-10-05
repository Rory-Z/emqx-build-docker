IMAGE_NAME=emqx-alpine-build-env
CONTAINER_NAME=test
VOLUMN_PATH=/opt
EMQX_VERSION=v3.0-beta.4


docker build -t ${IMAGE_NAME} ./emqx-alpine-build-env

docker run -it --rm \
	--name ${CONTAINER_NAME} \
	-v $(pwd)/emqx-docker:${VOLUMN_PATH} \
	${IMAGE_NAME} \
	sh -c "git clone -b ${EMQX_VERSION} https://github.com/emqx/emqx-rel /emqx && cd /emqx  && make && cp -r  /emqx/_rel/emqx ${VOLUMN_PATH}"

docker build -t emqx:${EMQX_VERSION} ./emqx-docker

docker save -o emqx-docker-${EMQX_VERSION}.zip emqx:${EMQX_VERSION}

docker rmi ${IMAGE_NAME}
