### Build:

```
$ ./docker-do.sh rebuild apache-server qiushihe/apache-server ./apache-server \
  -p 8080:80
```

Also accepts environment variables:

* `APACHE_SERVER_USER_ID`
* `APACHE_SERVER_GROUP_ID`
* `APACHE_SERVER_NFS_HOST`
* `APACHE_SERVER_NFS_SHARE`

... and when using NFS the `SYS_ADMIN` capability is required.

### Run:

```
$ docker start apache-server
```
