### Build:

```
$ ./docker-do.sh rebuild le-servo-server qiushihe/le-servo-server ./le-servo-server \
  -p 80:80 \
  -e 'LE_SERVO_SERVER_HOST_NAME="localhost"' \
  -e 'LE_SERVO_SERVER_PORT="80"'
```

### Run:

```
$ docker start le-servo-server
```
