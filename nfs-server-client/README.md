### Build:

```
$ ./docker-do.sh rebuild nfs-server-client qiushihe/nfs-server-client ./nfs-server-client \
  --cap-add=SYS_ADMIN
```

### Run:

```
$ docker start nfs-server-client
```
