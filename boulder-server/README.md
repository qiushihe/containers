Bases on:

* https://github.com/letsencrypt/boulder
* https://github.com/greenhost/certbot-haproxy

### Build:

```
$ ./docker-do.sh rebuild boulder-server qiushihe/boulder-server ./boulder-server \
  -e 'BOULDER_SERVER_FAKE_DNS_HOST="client-container-name"' \
  -e 'BOULDER_SERVER_FAKE_DNS_DOMAIN_1="test-1.domain.com"' \
  -e 'BOULDER_SERVER_FAKE_DNS_DOMAIN_2="test-2.domain.com"'
```

### Run:

```
$ docker start boulder-server
```
