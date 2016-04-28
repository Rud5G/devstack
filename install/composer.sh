#!/usr/bin/env bash

# see: https://getcomposer.org/download/
php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
php composer-setup.php
php -r "unlink('composer-setup.php');"

