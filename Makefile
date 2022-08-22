
.PHONY: all container run sshkey

all: container

container: ssh/id_rsa_fedora
	podman build -t fedora-devel .

run:
	podman run -it --rm fedora-devel

sshkey: ssh/id_rsa_fedora

ssh/id_rsa_fedora:
	ssh-keygen -t rsa -f ssh/id_rsa_fedora -N '' -C filbranden@podman-mac

