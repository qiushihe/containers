Based on: https://wiki.alpinelinux.org/wiki/Nginx_with_PHP

### Build:

```
$ ./docker-do.sh rebuild nginx-server qiushihe/nginx-server ./nginx-server \
  -p 8080:80
```

Also accepts environment variables:

* `NGINX_SERVER_NFS_HOST`
* `NGINX_SERVER_NFS_SHARE`

... and when using NFS the `SYS_ADMIN` capability is required.

### Run:

```
$ docker start nginx-server
```
