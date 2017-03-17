### Build:

```
$ ./docker-do.sh rebuild domain-proxy qiushihe/domain-proxy ./domain-proxy \
  -p 9000:9000 \
  -e 'DOMAIN_PROXY_PORT_1="9000"' \
  -e 'DOMAIN_PROXY_PORT_1_DOMAIN_1="domain-one.com"' \
  -e 'DOMAIN_PROXY_PORT_1_DESTINATION_1="destination.one:9001"' \
  -e 'DOMAIN_PROXY_PORT_1_DOMAIN_2="domain-two.com"' \
  -e 'DOMAIN_PROXY_PORT_1_DESTINATION_2="destination.two:9002"' \
  -p 8080:80 \
  -e 'DOMAIN_PROXY_PORT_2="80"' \
  -e 'DOMAIN_PROXY_PORT_2_DOMAIN_1="domain-one.com"' \
  -e 'DOMAIN_PROXY_PORT_2_DESTINATION_1="destination.one:80"' \
  -e 'DOMAIN_PROXY_PORT_2_DOMAIN_2="domain-two.com"' \
  -e 'DOMAIN_PROXY_PORT_2_DESTINATION_2="destination.two:80"'
```

### Run:

```
$ docker start domain-proxy
```
