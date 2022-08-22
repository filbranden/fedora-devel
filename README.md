# Container image for Fedora development

This image includes most Fedora tools used for RPM development, such as `fedpkg` and `koji`.

It also includes local compilers and build tools in order to test packages locally using `fedpkg local`.

Building it requires SSH keys for Fedora, you can generate those using `make sshkey`, then upload the contents of the generated `ssh/id_rsa_fedora.pub` to the SSH keys section in your Fedora account profile. (The SSH key is required to use `fedpkg clone` in order to check out repositories from Pagure.)

This requires `podman` to be installed and configured. You can build a local image with `podman build -t fedora-devel .` or just use `make`.

Run the container with `podman run -it --rm fedora-devel` or just use `make run`.

If you wish to run `koji build`, you first need to log in to Kerberos with `fkinit -u filbranden`.

This image uses filbranden's user name, email, full name in a few locations, in particular in the Containerfile (while creating the user account inside the container, etc.) and in the gitconfig (user name and email for commits.) If you wish to use this container setup for a different user, make sure you update those configs first, before building the container for yourself.

