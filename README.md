# OpenConnect

## Build
Via GitHub repository
```bash
$ docker build --tag alireaza/openconnect:$(date -u +%Y%m%d) --tag alireaza/openconnect:latest https://github.com/alireaza/openconnect.git
```

## Run
SOCKS5:1080
```bash
$ docker run --interactive --tty --rm --env="url=SERVER" --env="username=USERNAME" --env="password=PASSWORD" --publish="1080:1080" --name="openconnect" alireaza/openconnect
```

