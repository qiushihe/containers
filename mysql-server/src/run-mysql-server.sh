#!/bin/bash

runAs="root"
rootPassword=$MYSQL_SERVER_ROOT_PASSWORD

read -r -d '' secureSetupQueries << EOSQL
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.user WHERE User = '';
DELETE FROM mysql.user where Host NOT IN ('localhost', '127.0.0.1', '::1');
UPDATE mysql.user SET Password = PASSWORD('$rootPassword') WHERE User = 'root' AND Host != 'localhost';
FLUSH PRIVILEGES;
EOSQL

rm -fr /run/mysqld
mkdir -p /run/mysqld
chown -R $runAs:$runAs /run/mysqld

if [ -d "/mysql-data/mysql" ]; then
  echo "MySQL data already initialized in /mysql-data/mysql"
else
  mysql_install_db --user=$runAs --datadir=/mysql-data
  echo "!!! Initialized MySQL data in /mysql-data/mysql"

  # Start MySQL in socket-only mode for initial setup
  mysqld --user=$runAs --datadir=/mysql-data --skip-networking & mysqldPid="$!"
  while true; do
    if mysql --protocol=socket --user=root -e 'SELECT 1' &> /dev/null; then
      break
    else
      echo "!!! MySQL in socket-only mode not started; waiting ..."
      sleep 5
    fi
  done

  # Run setup queries
  cat <(echo $secureSetupQueries) | mysql --protocol=socket --user=root
  echo "!!! Finished running secure setup queries"

  # Stop socket-only MySQL
  kill -s TERM "$mysqldPid"
  wait "$mysqldPid"
  echo "!!! MySQL in socket-only mode stopped"
fi

# Start MySQL in socket-only mode for user setup
mysqld --user=$runAs --datadir=/mysql-data --skip-networking & mysqldPid="$!"
while true; do
  if mysql --protocol=socket --user=root -e 'SELECT 1' &> /dev/null; then
    break
  else
    echo "!!! MySQL in socket-only mode not started; waiting ..."
    sleep 5
  fi
done

MYSQL_SERVER_USERS=$(compgen -A variable | grep -e "^MYSQL_SERVER_USER_[^_]\+$")
for user in $MYSQL_SERVER_USERS; do
  index=${user##*_}
  pass=MYSQL_SERVER_PASSWORD_$index

  username=${!user}
  password=${!pass}

  result=`mysql --user=root -e "SELECT schema_name FROM information_schema.schemata WHERE schema_name = '$username';"`
  if [ -n "$result" ]; then
    echo "!!! Database $username already exist"
  else
    mysql --user=root -e "CREATE DATABASE $username;"
    result=`mysql --user=root -e "SELECT schema_name FROM information_schema.schemata WHERE schema_name = '$username';"`
    if [ -n "$result" ]; then
      echo "!!! Database $username created"
    else
      echo "!!! ERROR creating database $username"
    fi
  fi

  result=`mysql --user=root -e "SELECT user FROM mysql.user WHERE user = '$username';"`
  if [ -n "$result" ]; then
    echo "!!! User $username already exist"
  else
    mysql --user=root -e "create user '$username'@'%' identified by '$password';"
    result=`mysql --user=root -e "SELECT user FROM mysql.user WHERE user = '$username';"`
    if [ -n "$result" ]; then
      mysql --user=root -e "GRANT ALL PRIVILEGES ON $username.* TO '$username'@'%';"
      echo "!!! User $username created"
    else
      echo "!!! ERROR creating user $username"
    fi
  fi
done

# Stop socket-only MySQL
kill -s TERM "$mysqldPid"
wait "$mysqldPid"
echo "!!! MySQL in socket-only mode stopped"

echo "!!! Starting MySQL server"
mysqld --user=$runAs --datadir=/mysql-data
