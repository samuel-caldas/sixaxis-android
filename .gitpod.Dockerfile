FROM gitpod/workspace-full-vnc:latest

USER root

RUN echo "Set disable_coredump false" >> /etc/sudo.conf
RUN echo "gitpod:root" | chpasswd
RUN echo "gitpod:gitpod" | chpasswd

# APT section
RUN add-apt-repository ppa:maarten-fonville/android-studio -y
RUN apt-get update && apt-get install -y \
        android-studio \
        openssl \
        tmux \
        bc \
        bison \
        build-essential \
        ccache \
        curl \
        flex \
        g++-multilib \
        gcc-multilib \
        git \
        gnupg \
        gperf \
        imagemagick \
        lib32ncurses5-dev \
        lib32readline-dev \
        lib32z1-dev \
        liblz4-tool \
        libncurses5 \
        libncurses5-dev \
        libsdl1.2-dev \
        libssl-dev \
        libxml2 \
        libxml2-utils \
        lzop \
        pngcrush \
        rsync \
        schedtool \
        squashfs-tools \
        xsltproc \
        zip \
        zlib1g-dev \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*;

# Tmate section
RUN wget -P /home/gitpod/ https://github.com/tmate-io/tmate/releases/download/2.4.0/tmate-2.4.0-static-linux-amd64.tar.xz
RUN tar -C /home/gitpod/ -xf tmate-2.4.0-static-linux-amd64.tar.xz
RUN mv /home/gitpod/tmate-2.4.0-static-linux-amd64/tmate /home/gitpod/bin/tmate
RUN rm -R /home/gitpod/tmate-2.4.0-static-linux-amd64
RUN rm -R /home/gitpod/tmate-2.4.0-static-linux-amd64.tar.xz
RUN chmod a+x /home/gitpod/bin/tmate;
RUN sudo -u gitpod echo 'set tmate-api-key "tmk-7KLySbafzKyMFRjgAZuAbV3vm2"'    >> /home/gitpod/.tmate.conf
RUN sudo -u gitpod echo 'set tmate-session-name "lineage17"'                    >> /home/gitpod/.tmate.conf

# code-server section
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN mkdir -p /home/gitpod/.config/code-server
RUN echo 'bind-addr: 0.0.0.0:8080'  >> /home/gitpod/.config/code-server/config.yaml
RUN echo 'auth: none'              >> /home/gitpod/.config/code-server/config.yaml
RUN echo 'cert: false'        >> /home/gitpod/.config/code-server/config.yaml
RUN echo 'user-data-dir: /workspace/Gitpod-LineageOS-Build/code-server' >> /home/gitpod/.config/code-server/config.yaml 

USER gitpod

# Give back control
USER root
