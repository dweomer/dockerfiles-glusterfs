UBUNTU    := xenial
GLUSTERFS := 4.1

build: build-server

build-client:
	docker image build \
		--build-arg UBUNTU=$(UBUNTU) \
		--build-arg GLUSTERFS=$(GLUSTERFS) \
		--tag dweomer/glusterfs-client:$(GLUSTERFS)-$(UBUNTU) \
		--target glusterfs-client \
		.

build-server: build-client
	docker image build \
		--build-arg UBUNTU=$(UBUNTU) \
		--build-arg GLUSTERFS=$(GLUSTERFS) \
		--tag dweomer/glusterfs-server:$(GLUSTERFS)-$(UBUNTU) \
		--target glusterfs-server \
		.

xenial bionic:
	make -C . UBUNTU=$@

.PHONE: build build-client build-server xenial bionic