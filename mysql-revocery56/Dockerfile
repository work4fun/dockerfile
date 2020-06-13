FROM ubuntu:16.04 as xtrabackup

RUN apt-get update \
    && apt-get install -y wget git \
    && apt-get install -y build-essential flex bison automake autoconf \
        libtool cmake libaio-dev mysql-client libncurses-dev zlib1g-dev \
        libgcrypt11-dev libev-dev libcurl4-gnutls-dev vim-common

RUN cd ~ \ 
    && git clone --progress https://github.com/percona/percona-xtrabackup.git  \
    && cd percona-xtrabackup \
    && git checkout 2.3 \
    && cmake -DBUILD_CONFIG=xtrabackup_release -DWITH_MAN_PAGES=OFF && make -j4 \
    && make install

FROM mysql:5.6

COPY --from=xtrabackup /usr/local/xtrabackup /usr/local/xtrabackup