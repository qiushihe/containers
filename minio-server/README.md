### Build:

```
$ ./docker-do.sh rebuild minio-server qiushihe/minio-server ./minio-server \
  -p 9000:9000 \
  -v $(pwd)/volumes/minio-server:/minio-data \
  -e 'MINIO_SERVER_ACCESS_KEY="access-key"' \
  -e 'MINIO_SERVER_SECRET_KEY="secret-key"'
```

Also accepts environment variables:

* `MINIO_SERVER_NFS_HOST`
* `MINIO_SERVER_NFS_SHARE`

... and when using NFS the `SYS_ADMIN` capability is required.

### Run:

```
$ docker start minio-server
```

### Cyberduck with HTTP S3 Connection

https://trac.cyberduck.io/wiki/help/en/howto/s3#HTTP
