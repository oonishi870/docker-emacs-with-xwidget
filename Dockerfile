FROM ubuntu:24.04 AS builder

RUN apt update
RUN apt install -y git

RUN apt install -y  build-essential       \
                    texinfo               \
                    gnutls-bin            \
                    libgccjit-10-dev      \
                    zlib1g-dev            \
                    libncurses-dev        \
                    libgtk-3-dev          \
                    xorg-dev              \
                    libjpeg-dev           \
                    libgif-dev            \
                    libtiff-dev           \
                    libgnutls28-dev       \
                    librsvg2-dev          \
                    libcairo-5c-dev       \
                    liblcms2-dev          \
                    libgpm-dev            \
                    libacl1-dev           \
                    libxml2-dev           \
                    libm17n-dev           \
                    libotf-dev            \
                    libsystemd-dev        \
                    libjansson-dev        \
                    libsqlite3-dev        \
                    webkit2gtk-driver     \
                    libwebkit2gtk-4.1-0   \
                    libwebkit2gtk-4.1-dev \
                    libmagickwand-dev


WORKDIR /root
RUN git clone --depth 1 --branch  emacs-29.1 git://git.savannah.gnu.org/emacs.git  emacs-29.1

WORKDIR /root/emacs-29.1/
RUN ./autogen.sh
RUN CFLAGS='-I/usr/lib/gcc/x86_64-linux-gnu/10/include -L/usr/lib/gcc/x86_64-linux-gnu/10' ./configure --with-native-compilation --without-pop --with-xwidgets --with-imagemagick --with-pgtk
RUN make

FROM ubuntu:24.04

RUN apt update
RUN apt install -y git

RUN apt install -y  make                  \
                    texinfo               \
                    gnutls-bin            \
                    libgccjit-10-dev      \
                    zlib1g-dev            \
                    libncurses-dev        \
                    libgtk-3-dev          \
                    xorg-dev              \
                    libjpeg-dev           \
                    libgif-dev            \
                    libtiff-dev           \
                    libgnutls28-dev       \
                    librsvg2-dev          \
                    libcairo-5c-dev       \
                    liblcms2-dev          \
                    libgpm-dev            \
                    libacl1-dev           \
                    libxml2-dev           \
                    libm17n-dev           \
                    libotf-dev            \
                    libsystemd-dev        \
                    libjansson-dev        \
                    libsqlite3-dev        \
                    webkit2gtk-driver     \
                    libwebkit2gtk-4.1-0   \
                    libwebkit2gtk-4.1-dev \
                    libmagickwand-dev


RUN --mount=type=bind,from=builder,source=/root/emacs-29.1,target=/root/emacs-29.1 \
    cd /root/emacs-29.1/ \
    && make install 


# RUN apt install -y emacs-mozc-bin  emacs-mozc
# RUN apt install -y fcitx5-mozc

