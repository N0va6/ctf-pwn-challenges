FROM ubuntu:24.04

LABEL Author="N0va6" Challenge="miragevm"

ENV DEBIAN_FRONTEND=noninteractive

RUN if [ -f /etc/apt/sources.list ]; then \
        sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list; \
        sed -i "s/http:\/\/security.ubuntu.com/http:\/\/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list; \
    fi && \
    if [ -f /etc/apt/sources.list.d/ubuntu.sources ]; then \
        sed -i "s#http://archive.ubuntu.com/ubuntu/#https://mirrors.tuna.tsinghua.edu.cn/ubuntu/#g" /etc/apt/sources.list.d/ubuntu.sources; \
        sed -i "s#http://security.ubuntu.com/ubuntu/#https://mirrors.tuna.tsinghua.edu.cn/ubuntu/#g" /etc/apt/sources.list.d/ubuntu.sources; \
    fi && \
    apt-get update && \
    apt-get install -y --no-install-recommends xinetd ca-certificates coreutils bash && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m ctf

WORKDIR /home/ctf

RUN cp -R /lib* /home/ctf && \
    cp -R /usr/lib* /home/ctf

RUN mkdir /home/ctf/dev && \
    mknod /home/ctf/dev/null c 1 3 && \
    mknod /home/ctf/dev/zero c 1 5 && \
    mknod /home/ctf/dev/random c 1 8 && \
    mknod /home/ctf/dev/urandom c 1 9 && \
    chmod 666 /home/ctf/dev/*

RUN mkdir /home/ctf/bin && \
    cp /bin/sh /home/ctf/bin && \
    cp /bin/ls /home/ctf/bin && \
    cp /bin/cat /home/ctf/bin && \
    cp /usr/bin/timeout /home/ctf/bin || true

COPY ./config/ctf.xinetd /etc/xinetd.d/ctf
COPY ./service/docker-entrypoint.sh /
RUN echo "Blocked by ctf_xinetd" > /etc/banner_fail
RUN chmod +x /docker-entrypoint.sh

COPY ./src/attachment /home/ctf/attachment

RUN chown -R root:ctf /home/ctf && \
    chmod -R 750 /home/ctf && \
    touch /home/ctf/flag && \
    chmod 744 /home/ctf/flag && \
    chmod 711 /home/ctf/attachment

EXPOSE 9999

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
