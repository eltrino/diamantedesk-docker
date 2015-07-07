# DiamanteDesk
DiamanteDesk is an independent support ticket system which is designed to listen to your customers and quickly react to satisfy their needs. Currently, it can be easily integrated into the Oro platform but in the short run it will be available for other CRM systems.

More info about DiamanteDesk you can see [here](http://diamantedesk.com)

# How to use this Docker image
## Prerequisites
You need Docker properly installed before you use this images.
More info about Docker [here](https://docs.docker.com)

Database is not included in the image, so you need to link another container with database installed.

Optionally you can use ```make``` to build image and run/stop containers.

## Run DiamanteDesk application using Makefile
1. Download [Makefile](https://raw.githubusercontent.com/eltrino/diamantedesk-docker/master/Makefile) to the folder of your chose
2. Run ```make runall``` in that folder
3. Go to http://127.0.0.1 (or check ```boot2docker ip``` if you are running docker inside boot2docker)
4. Run ```make stopall``` to stop application and db containers
5. Run ```make killall``` to stop and delete application and db containers

## Run DiamanteDesk application with docker cli
1. Run DB container 
```
docker run --name mysql56_diamante 
-e MYSQL_ROOT_PASSWORD={set root password}
-e MYSQL_DATABASE=diamantedesk 
-e MYSQL_USER=diamantedesk
-e MYSQL_PASSWORD={set user password} 
-d mysql:5.6
```
2. Run application container and link db
```
docker run 
--name diamante
-p 80:80 -p 8080:8080 
--link mysql56_diamante:{DB alias}
-d eltrino/diamante_desk
```
Set {DB alias} to any value you want and use it as DB hostname during installation


# Notes
Application in this image is not installed, so you have to proceed with web installer instructions.
Ability to install application automatically coming soon.