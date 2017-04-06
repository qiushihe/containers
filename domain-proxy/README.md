### Build:

```
$ ./docker-do.sh rebuild domain-proxy qiushihe/domain-proxy ./domain-proxy \
  --cap-add NET_ADMIN \
  -p 9000:9000 \
  -e 'DOMAIN_PROXY_FE_1="domain-one.com:9000"' \
  -e 'DOMAIN_PROXY_BE_1="destination.one:9001"' \
  -e 'DOMAIN_PROXY_FE_2="domain-two.com:9000"' \
  -e 'DOMAIN_PROXY_BE_2="destination.two:9002"' \
  -p 8080:80 \
  -e 'DOMAIN_PROXY_FE_3="domain-one.com:80"' \
  -e 'DOMAIN_PROXY_BE_3="destination.one:80"' \
  -e 'DOMAIN_PROXY_FE_4="domain-two.com:80"' \
  -e 'DOMAIN_PROXY_BE_4="destination.two:80"'
```

Also accepts environment variables:

* `DOMAIN_PROXY_USE_CERTBOT`: If set to non-empty value, the domain proxy server will use certbot to generate SSL certificates
* `DOMAIN_PROXY_BOULDER_HOST`: If set, the domain proxy server will use certbot in test mode to connect to this host instead of the official Let's Encrypt server

### Run:

```
$ docker start domain-proxy
```
