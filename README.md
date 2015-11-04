# Note: This image intended to use by developers
# DiamanteDesk
DiamanteDesk is an independent support ticket system which is designed to listen to your customers and quickly react to satisfy their needs. Currently, it can be easily integrated into the Oro platform but in the short run it will be available for other CRM systems.

To get more information about DiamanteDesk, click [here](http://docs.diamantedesk.com/en/latest/).

# How to Use Docker Image
## Prerequisites
Docker should be properly installed before this image is used.
To learn more information about Docker, click [here](https://docs.docker.com).

You have to checkout DiamanteDesk sources to src directory

The database is not included in the image, so you need to link another container with database installed.

Optionally, you can use ```docker-compose``` to build an image and run/stop containers.

## Run DiamanteDesk Application Using docker-compose
Just

~~~
$ docker-compose up
~~~

## Run DiamanteDesk Application with Docker CLI
1. Run DB container:

~~~
$ docker run --name mysql56_diamante -e MYSQL_ROOT_PASSWORD={set root password} -e MYSQL_DATABASE=diamantedesk -e MYSQL_USER=diamantedesk -e MYSQL_PASSWORD={set user password} -d mysql:5.6
~~~


2. Run application container and link DB:

~~~
$ docker run --name diamante -p 80:80 -p 8080:8080 --link mysql56_diamante:{DB alias} -d eltrino/diamante_desk
~~~

Set {DB alias} to any value you want and use it as DB hostname during installation.

# Notes
As an application in this image is not installed, you have to proceed with web installer instructions.
The possibility to install application automatically is coming soon.
