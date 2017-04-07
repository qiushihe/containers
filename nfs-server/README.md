### Build:

```
$ docker volume create --driver local nfs-data

$ ./docker-do.sh rebuild nfs-server qiushihe/nfs-server ./nfs-server \
  --cap-add=SYS_ADMIN \
  -v nfs-data:/exports \
  -e NFS_SERVER_SHARE_1="lala1" \
  -e NFS_SERVER_SHARE_2="lala2"
```

### Run:

```
$ docker start nfs-server
```
