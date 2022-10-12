FROM fedora:rawhide

# Install interesting packages
RUN sed -i 's/^tsflags=nodocs/#&/' /etc/dnf/dnf.conf
RUN dnf -y install fedora-packager fedora-review koji krb5-workstation util-linux man man-pages git gh vim wget bash-completion '@Development Tools' '@C Development Tools and Libraries'

# Create user account.
RUN useradd -m -c 'Filipe Brandenburger' -G wheel filbranden

# Copy SSH keys and configuration files.
ADD ssh /home/filbranden/.ssh
ADD gitconfig /home/filbranden/.gitconfig
ADD sudoers.d/* /etc/sudoers.d/
ADD krb5.conf.d/* /etc/krb5.conf.d/
RUN chown -R filbranden:filbranden /home/filbranden/

# Entry point, run as filbranden
USER filbranden
WORKDIR /home/filbranden
CMD ["/bin/bash", "-l"]

