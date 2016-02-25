#!/usr/bin/env bash



INSTALL_DIR=/var/www/magento
CURRENT_DIR=`pwd`

cd ${INSTALL_DIR}

git status

echo "resetting everything in 5sec!, if git status gave unexpected results use [ctrl]+C now!"

sleep 10;

# remove/reset entire directory!
rm -rf ${INSTALL_DIR}/htdocs

hhvm /usr/bin/composer run-script post-install-cmd -vvv -- --redeploy