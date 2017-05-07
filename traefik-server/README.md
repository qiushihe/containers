### Build:

```
$ ./docker-do.sh rebuild traefik-server qiushihe/traefik-server ./traefik-server \
  --cap-add NET_ADMIN \
  -p 8888:8080 \
  -p 8080:80 \
  -e 'TRAEFIK_SERVER_FE_1="Host:domain-one.com"' \
  -e 'TRAEFIK_SERVER_BE_1="http://destination.one:80"' \
  -e 'TRAEFIK_SERVER_FE_2="Host:domain-two.com"' \
  -e 'TRAEFIK_SERVER_BE_2="http://destination.two:80"'
```

### Run:

```
$ docker start traefik-server
```
