Based on: https://wiki.alpinelinux.org/wiki/Nginx_with_PHP

### Build:

```
$ ./docker-do.sh rebuild web-server qiushihe/web-server ./web-server \
  -p 8080:80
```

### Run:

```
$ docker start web-server
```
