FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
openconnect ocproxy \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

EXPOSE 1080

CMD export cert="$(\
    yes no | \
    openconnect "$url" 2>&1 >/dev/null | \
    grep 'servercert' | \
    cut -d ' ' -f 6)" \
    && \
    echo "$password" | \
    openconnect \
    --servercert $cert \
    --script-tun \
    --script "ocproxy -D 1080 -g" \
    --user=$username \
    $url
