### Build:

```
$ ./docker-do.sh rebuild boulder-server-client qiushihe/boulder-server-client ./boulder-server-client \
  -p 8080:80 \
  -p 8443:443 \
  -e 'BOULDER_SERVER_CLIENT_TEST_SERVER="boulder-server-container-name"'
```

### Run:

```
$ docker start boulder-server-client
```
