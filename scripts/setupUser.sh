#!/bin/bash

user=$1
pswd=$2
ADMIN_PASSWORD=$(pwgen 10 1)                                                                                                                                                                                                                                                   
JEM=$(which jem)
MYSQL=$(which mysql)
MYSQLD_SAFE=$(which mysqld_safe)
unset resp;
full_version=$(mysql --version|awk '{ print $5 }'|awk -F\, '{ print $1 }')
version=${full_version%.*} 
resp=$(mysql -u$user -p$pswd mysql --execute="SHOW COLUMNS FROM user" 2>/dev/null);
res=$?;
if [ "$res" -eq 0 ] ; then
    echo "[Info] User $user has the required access to the database." 
else
    if (( $(awk 'BEGIN {print ('$version' >= 10.4)}') )); then
        $JEM passwd set -p $ADMIN_PASSWORD
        cmd="CREATE USER '$user'@'localhost' IDENTIFIED BY '$pswd'; CREATE USER '$user'@'%' IDENTIFIED BY '$pswd'; GRANT ALL PRIVILEGES ON *.* TO '$user'@'localhost' WITH GRANT OPTION; GRANT ALL PRIVILEGES ON *.* TO '$user'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"
        $MYSQL -uroot -p${ADMIN_PASSWORD} --execute="$cmd"
    else
        service mysql stop;
        $MYSQLD_SAFE --skip-grant-tables --user=mysql --pid-file=/var/lib/mysql/$(hostname).pid &
        sleep 5
        cmd="CREATE TEMPORARY TABLE tmptable SELECT * FROM user WHERE User = 'root'; UPDATE tmptable SET User = '$user' WHERE User = 'root'; DELETE FROM user WHERE User = '$user'; INSERT INTO user SELECT * FROM tmptable WHERE User = '$user'; DROP TABLE tmptable;"
        $MYSQL mysql --execute="$cmd"
        cmd="UPDATE user SET password=PASSWORD('$pswd') WHERE user='$user';";
        $MYSQL mysql --execute="$cmd"
        echo $resp
        rm -f /var/lib/mysql/auto.cnf
        service mysql restart
    fi
fi
