FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
openconnect ocproxy privoxy \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN touch /privoxy.conf
RUN echo "listen-address 0.0.0.0:9053" >> /privoxy.conf
RUN echo "forward-socks5 / localhost:9052 ." >> /privoxy.conf

EXPOSE 9052
EXPOSE 9053

CMD privoxy /privoxy.conf \
    && \
    export cert="$(\
    yes no | \
    openconnect "$url" 2>&1 >/dev/null | \
    grep 'servercert' | \
    cut -d ' ' -f 6)" \
    && \
    echo "$password" | \
    openconnect \
    --servercert $cert \
    --script-tun \
    --script "ocproxy -D 9052 -g" \
    --user=$username \
    $url
