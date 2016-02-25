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

```sh
$ bin/dkipbyname devstack_web
```

You can access your configured sites via the IP address of the Docker Machine or locally if you're running a Linux flavour and using Docker natively.
Optional setup the ip-address from the above command in /etc/hosts


```sh
$ composer create-project phpmyadmin/phpmyadmin --repository-url=https://www.phpmyadmin.net/packages.json
```
 