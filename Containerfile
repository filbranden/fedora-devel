FROM fedora:latest

# Install interesting packages
RUN sed -i 's/^tsflags=nodocs/#&/' /etc/dnf/dnf.conf
RUN dnf -y install fedora-packager fedora-review koji krb5-workstation util-linux man man-pages git vim '@Development Tools' '@C Development Tools and Libraries'

# Configure fkinit to use local cache instead of the kernel keyring KCM: which
# doesn't work inside a container.
# (see also: https://github.com/containers/toolbox/issues/235)
RUN grep -q 'default_ccache_name = FILE:/tmp/krb5.ccache' /etc/krb5.conf || ex -s -c $'/^\[libdefaults/a\n    default_ccache_name = FILE:/tmp/krb5.ccache\n.\nwq' /etc/krb5.conf

# Create user account.
RUN useradd -m -c 'Filipe Brandenburger' -G wheel filbranden

# Copy SSH keys and configuration files.
ADD ssh /home/filbranden/.ssh
ADD gitconfig /home/filbranden/.gitconfig
ADD sudoers.d/* /etc/sudoers.d/
RUN chown -R filbranden:filbranden /home/filbranden/

# Entry point, run as filbranden
USER filbranden
WORKDIR /home/filbranden

