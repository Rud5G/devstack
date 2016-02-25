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
APPLY_UPDATES=https://gist.githubusercontent.com/Rud5G/5b39ecef0560b0027627/raw/aa6c82d1f36c01933e86179a80ba35a2d00c7eba/apply-updates.php


# prevent unwanted deleting
echo ""
echo ""
echo ""
echo "resetting entire magento installation in 10sec!, if git status has unexpected results use [ctrl]+C now!"

echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
sleep 10;

# start composer setup+install
cd ${INSTALL_DIR}
hhvm /usr/bin/composer install -vvv

# remove/reset entire magento installation!
rm -rf ${INSTALL_DIR}/htdocs ${INSTALL_DIR}/bin
cp -pr ${INSTALL_DIR}/vendor/firegento/magento ${INSTALL_DIR}/htdocs
hhvm /usr/bin/composer run-script post-install-cmd -vvv -- --redeploy

rm -f ${INSTALL_DIR}/htdocs/.gitignore && for link in `find htdocs/ -type l 2>/dev/null`; do rellink=${link:7}; echo $rellink >> htdocs/.gitignore ; done

touch ${INSTALL_DIR}/htdocs/maintenance.flag

wget -q ${APPLY_UPDATES} -O ${INSTALL_DIR}/htdocs/shell/apply-updates.php

echo "DROP DATABASE IF EXISTS ${DB_NAME}; CREATE DATABASE ${DB_NAME};" | mysql -h${DB_HOST} -p${DB_PASS} -P${DB_PORT} -u${DB_USER}

rm -f ${INSTALL_DIR}/htdocs/app/etc/local.xml && hhvm -f ${INSTALL_DIR}/htdocs/install.php -- \
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
        --url "http://${MAGENTO_HOSTNAME}/" \
        --secure_base_url "http://${MAG_HOST}/" \
        --db_host "${DB_HOST}" \
        --db_name "${DB_NAME}" \
        --db_user "${DB_USER}" \
        --db_pass "${DB_PASS}"
hhvm ${INSTALL_DIR}/htdocs/shell/apply-updates.php run
rm -rf ${INSTALL_DIR}/htdocs/var/*
rm ${INSTALL_DIR}/htdocs/maintenance.flag

echo "installed"
