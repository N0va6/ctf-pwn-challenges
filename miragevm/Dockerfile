FROM ubuntu:24.04

LABEL Author="N0va6" Challenge="miragevm"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends xinetd ca-certificates bash && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m ctf

WORKDIR /home/ctf

RUN mkdir -p /home/ctf/lib /home/ctf/lib64 /home/ctf/usr/lib /home/ctf/bin && \
    cp -aL /lib/x86_64-linux-gnu /home/ctf/lib/ && \
    cp -aL /usr/lib/x86_64-linux-gnu /home/ctf/usr/lib/ && \
    cp -aL /lib64/ld-linux-x86-64.so.2 /home/ctf/lib64/ && \
    cp -aL /bin/sh /home/ctf/bin/sh && \
    cp -aL /bin/ls /home/ctf/bin/ls && \
    cp -aL /bin/cat /home/ctf/bin/cat

RUN mkdir /home/ctf/dev && \
    mknod /home/ctf/dev/null c 1 3 && \
    mknod /home/ctf/dev/zero c 1 5 && \
    mknod /home/ctf/dev/random c 1 8 && \
    mknod /home/ctf/dev/urandom c 1 9 && \
    chmod 666 /home/ctf/dev/*

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
