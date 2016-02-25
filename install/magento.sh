#!/usr/bin/env bash

# defines
INSTALL_DIR=/var/www/magento
START_DIR=`pwd`


# start
cd ${INSTALL_DIR}

hhvm /usr/bin/composer install

echo "resetting everything in 10sec!, if git status gave unexpected results use [ctrl]+C now!"

sleep 10;

# remove/reset entire directory!
rm -rf ${INSTALL_DIR}/htdocs

cp -pr ${INSTALL_DIR}/vendor/firegento/magento ${INSTALL_DIR}/htdocs

hhvm /usr/bin/composer run-script post-install-cmd -vvv -- --redeploy

