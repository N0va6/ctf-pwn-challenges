FROM ubuntu:24.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends socat ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m ctf
WORKDIR /home/ctf

COPY miragevm /home/ctf/miragevm
COPY run.sh /home/ctf/run.sh

RUN chmod 755 /home/ctf/miragevm /home/ctf/run.sh \
    && echo 'flag{test_flag}' > /flag \
    && chmod 444 /flag

USER ctf

EXPOSE 9999
CMD ["socat", "TCP-LISTEN:9999,reuseaddr,fork", "EXEC:/home/ctf/run.sh,stderr"]
