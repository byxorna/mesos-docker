FROM debian:jessie
MAINTAINER Gabe Conradi <gummybearx@gmail.com>

ENV MAVEN_VERSION 3.2.5
ENV MESOS_VERSION 0.22.1
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/lib/libmesos.so
ENV MESOS_NATIVE_LIBRARY /usr/lib/libmesos.so
RUN apt-get update && \
  apt-get install -y curl \
    build-essential \
    autoconf \
    libtool \
    libsvn-dev \
    libcurl4-nss-dev \
    zlib1g-dev \
    libsasl2-dev \
    libapr1-dev \
    maven && \
  rm -rf /var/lib/apt/cache/lists/* && \
  mkdir /mesos && cd /mesos && curl -L "https://github.com/apache/mesos/archive/${MESOS_VERSION}.tar.gz" | tar xvz --strip-components 1 && \
  ls -la && ./bootstrap && PATH=/build/bin:$PATH ./configure --prefix=/usr --disable-python && make && make install && rm -rf /mesos && \
  apt-get remove --auto-remove build-essential autoconf libtool libsvn-dev libcurl4-nss-dev zlib1g-dev libsasl2-dev libapr1-dev maven && \
  find / |grep libmesos

