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
RUN make install

FROM ubuntu:24.04

# 実行時に必要なパッケージのみをインストール
RUN apt update && apt install -y  \
    libgccjit0                    \
    zlib1g                        \
    libncurses6                   \
    libgtk-3-0                    \
    libx11-6                      \
    libjpeg8                      \
    libgif7                       \
    libtiff6                      \
    libgnutls30                   \
    librsvg2-2                    \
    libcairo2                     \
    liblcms2-2                    \
    libgpm2                       \
    libacl1                       \
    libxml2                       \
    libm17n-0                     \
    libotf1                       \
    libsystemd0                   \
    libjansson4                   \
    libsqlite3-0                  \
    libwebkit2gtk-4.1-0           \
    libmagickwand-6.q16-7t64      \
    build-essential               \
    libgccjit-10-dev              \
    libwebpdecoder3               \
    libglib2.0-bin                \
    && apt-get clean
    
#    && rm -rf /var/lib/apt/lists/*
# RUN rm -rf /var/lib/apt/lists/*

# RUN apt install -y libgccjit-10-dev
# RUN apt install -y libwebpdecoder3
# RUN apt install -y libglib2.0-bin

RUN --mount=type=bind,from=builder,source=/root/emacs-29.1,target=/root/emacs-29.1 \
    cd /root/emacs-29.1/ \
    && make install 

ENTRYPOINT ["emacs"]


# RUN apt install -y emacs-mozc-bin  emacs-mozc
# RUN apt install -y fcitx5-mozc

