FROM ubuntu:18.04

RUN apt-get update \
&& apt-get install -y --no-install-recommends openconnect ocproxy polipo \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

EXPOSE 9052
EXPOSE 9053

CMD polipo \
    socksParentProxy=127.0.0.1:9052 \
    socksProxyType=socks5 \
    proxyAddress=0.0.0.0 \
    proxyPort=9053 \
    daemonise=true \
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
