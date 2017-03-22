Based on: https://wiki.alpinelinux.org/wiki/Nginx_with_PHP

### Build:

```
$ ./docker-do.sh rebuild nginx-server qiushihe/nginx-server ./nginx-server \
  -p 8080:80
```

### Run:

```
$ docker start nginx-server
```
