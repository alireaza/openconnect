# OpenConnect

## Build
Via GitHub repository
```bash
$ docker build --tag alireaza/openconnect:$(date -u +%Y%m%d) --tag alireaza/openconnect:latest https://github.com/alireaza/openconnect.git
```

## Run
SOCKS5:9052
```bash
$ docker run --interactive --tty --rm --env="url=SERVER" --env="username=USERNAME" --env="password=PASSWORD" --publish="9052:9052" --name="openconnect" alireaza/openconnect
```

