FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install -y mercurial
RUN apt-get install -y git
RUN apt-get install -y python
RUN apt-get install -y curl
RUN apt-get install -y vim
RUN apt-get install -y strace
RUN apt-get install -y diffstat
RUN apt-get install -y pkg-config
RUN apt-get install -y cmake
RUN apt-get install -y build-essential
RUN apt-get install -y tcpdump
RUN apt-get install -y screen

# Install Python.
RUN \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

# Setup home environment
RUN useradd dev
RUN mkdir /home/dev && chown -R dev: /home/dev
RUN mkdir -p /home/dev/go /home/dev/bin /home/dev/lib /home/dev/include
ENV PATH /home/dev/bin:$PATH
ENV PKG_CONFIG_PATH /home/dev/lib/pkgconfig
ENV LD_LIBRARY_PATH /home/dev/lib

# Create a shared data volume
# We need to create an empty file, otherwise the volume will
# belong to root.
# This is probably a Docker bug.
RUN mkdir /var/shared/
RUN touch /var/shared/placeholder
RUN chown -R dev:dev /var/shared
VOLUME /var/shared

WORKDIR /home/dev
ENV HOME /home/dev
#ADD vimrc /home/dev/.vimrc
#ADD vim /home/dev/.vim
#ADD bash_profile /home/dev/.bash_profile
#ADD gitconfig /home/dev/.gitconfig

# Link in shared parts of the home directory
#RUN ln -s /var/shared/.ssh
#RUN ln -s /var/shared/.bash_history
#RUN ln -s /var/shared/.maintainercfg

RUN chown -R dev: /home/dev


# give sudo rights, set password
run adduser dev sudo
run echo "dev:dev" | chpasswd

# install docker so we can do inception
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
RUN curl -sSL https://get.docker.com/ | sh

# perms
run usermod -aG docker dev


USER dev

# set prompt (not working for now)
ENV PS1 '${debian_chroot:+($debian_chroot)}($BOX_NAME) \u@\h:\w\$'