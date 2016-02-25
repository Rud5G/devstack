#!/usr/bin/env bash

# defines
INSTALL_DIR=/var/www/magento
START_DIR=`pwd`
MAGENTO_HOSTNAME=magento.dev
DB_HOST=$MYSQL_1_PORT_3306_TCP_ADDR
DB_USER=root
DB_PASS=$MYSQL_1_ENV_MYSQL_ROOT_PASSWORD
DB_PORT=$MYSQL_1_PORT_3306_TCP_PORT
DB_NAME=magento
APPLY_UPDATES=https://gist.githubusercontent.com/Rud5G/5b39ecef0560b0027627/raw/bb6a03df7617063c3a6852cab633d2b0042ef276/apply-updates.php


# start composer setup+install
cd ${INSTALL_DIR}
hhvm /usr/bin/composer install

# remove/reset entire magento installation!
git status
echo "resetting entire magento installation in 10sec!, if git status gave unexpected results use [ctrl]+C now!"
sleep 10;
rm -rf ${INSTALL_DIR}/htdocs ${INSTALL_DIR}/bin
cp -pr ${INSTALL_DIR}/vendor/firegento/magento ${INSTALL_DIR}/htdocs
hhvm /usr/bin/composer run-script post-install-cmd -vvv -- --redeploy

touch ${INSTALL_DIR}/htdocs/maintenance.flag

wget ${APPLY_UPDATES} -O ${INSTALL_DIR}/htdocs/shell/apply-updates.php

echo "DROP DATABASE IF EXISTS ${DB_NAME}; CREATE DATABASE ${DB_NAME};" | mysql -h${DB_HOST} -p${DB_PASS} -P${DB_PORT} -u${DB_USER}

rm -f ${INSTALL_DIR}/htdocs/app/etc/local.xml && php -f ${INSTALL_DIR}/htdocs/install.php -- \
        --license_agreement_accepted "yes" \
        --locale "en_US" \
        --timezone "Europe/Berlin" \
        --default_currency "EUR" \
        --use_rewrites "yes" \
        --use_secure "no" \
        --use_secure_admin "no" \
        --skip_url_validation \
        --admin_firstname "FirstName" \
        --admin_lastname "LastName" \
        --admin_email "f.lastname@triple-networks.com" \
        --admin_username "admin" \
        --admin_password "magento123" \
        --url "http://${MAG_HOST}/" \
        --secure_base_url "http://${MAG_HOST}/" \
        --db_host "${DB_HOST}" \
        --db_name "${DB_NAME}" \
        --db_user "${DB_USER}" \
        --db_pass "${DB_PASS}"
php ${INSTALL_DIR}/htdocs/shell/apply-updates.php run
rm -rf ${INSTALL_DIR}/htdocs/var/*
rm ${INSTALL_DIR}/htdocs/maintenance.flag

echo "installed"
