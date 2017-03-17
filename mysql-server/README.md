Based on: https://github.com/inikolaev/docker-images/blob/master/alpine-mysql

### Build:

```
$ ./docker-do.sh rebuild mysql-server qiushihe/mysql-server ./mysql-server \
  -p 3306:3306 \
  -v $(pwd)/volumes/mysql-server:/mysql-data \
  -e 'MYSQL_SERVER_ROOT_PASSWORD="changeme"' \
  -e 'MYSQL_SERVER_USER_1="lala1"' \
  -e 'MYSQL_SERVER_PASSWORD_1="lala1pass"' \
  -e 'MYSQL_SERVER_USER_2="lala2"' \
  -e 'MYSQL_SERVER_PASSWORD_2="lala2pass"'
```

### Run:

```
$ docker start mysql-server
```
