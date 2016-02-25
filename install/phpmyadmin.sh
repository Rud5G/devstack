#!/usr/bin/env bash


INSTALL_DIR=/var/www/phpmyadmin/htdocs
CURRENT_DIR=`pwd`

/usr/bin/composer create-project phpmyadmin/phpmyadmin ${INSTALL_DIR} --repository-url=https://www.phpmyadmin.net/packages.json

cd ${INSTALL_DIR}


/usr/bin/composer config bin-dir "bin"
/usr/bin/composer config config.minimum-stability "dev"

