# DevStack

> Dockerized PHP development stack: Nginx, MySQL, PHP-FPM, HHVM and Redis

DevStack gives you a light development environment for developing PHP applications locally.

## What's inside

* [Nginx](http://nginx.org/)
* [MySQL](http://www.mysql.com/)
* [PHP-FPM](http://php-fpm.org/)
* [HHVM](http://www.hhvm.com/)
* [Redis](http://redis.io/)

## Requirements

* [Docker Engine](https://docs.docker.com/installation/)
* [Docker Compose](https://docs.docker.com/compose/)
* [Docker Machine](https://docs.docker.com/machine/) (Mac and Windows only)

## Running

Set up a Docker Machine and then run:

```sh
$ docker-compose up
```

To stop, use [ctrl]+C


the IP address of the Docker Machine 

```sh
$ dkipbyname devstack_web
```

Optional setup the ip-address from the above command in /etc/hosts



## WIP MANUAL

Optional add phpmyadmin 
```sh
$ mkdir /var/www/phpmyadmin/htdocs
```

```sh
$ /usr/bin/composer create-project phpmyadmin/phpmyadmin /var/www/phpmyadmin/htdocs --repository-url=https://www.phpmyadmin.net/packages.json
$ hhvm composer.phar create-project phpmyadmin/phpmyadmin /var/www/phpmyadmin/htdocs --repository-url=https://www.phpmyadmin.net/packages.json
```
 