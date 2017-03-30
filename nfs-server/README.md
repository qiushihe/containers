### Build:

```
$ docker volume create --driver local nfs-data

$ ./docker-do.sh rebuild nfs-server qiushihe/nfs-server ./nfs-server \
  --cap-add=SYS_ADMIN \
  -v nfs-data:/exports \
  -e 'NFS_SERVER_SHARES="lala1 lala2"'
```

### Run:

```
$ docker start nfs-server
```
