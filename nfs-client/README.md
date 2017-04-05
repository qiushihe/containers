### Build:

```
$ ./docker-do.sh rebuild nfs-client qiushihe/nfs-client ./nfs-client \
  --cap-add=SYS_ADMIN \
  -e 'NFS_CLIENT_NFS_SERVER="nfs-server"' \
  -e 'NFS_CLIENT_NFS_SHARE="lala1"'
```

### Run:

```
$ docker start nfs-client
```
