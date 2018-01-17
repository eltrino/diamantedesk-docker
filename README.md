# DiamanteDesk
DiamanteDesk is an independent support ticket system which is designed to listen to your customers and quickly react to satisfy their needs. Currently, it can be easily integrated into the Oro platform but in the short run it will be available for other CRM systems.

To get more information about DiamanteDesk, click [here](http://docs.diamantedesk.com/en/latest/).

# How to Use Docker Image
## Prerequisites
Docker should be properly installed before this image is used.
To learn more information about Docker, click [here](https://docs.docker.com).

The database is not included in the image, so you need to link another container with database installed.

Optionally, you can use ```docker-compose``` file to build an image and run/stop containers.

## Run DiamanteDesk Application Using docker-compose
1. Download [docker-compose.yml](https://raw.githubusercontent.com/eltrino/diamantedesk-docker/master/docker-compose.yml) to the folder of your choise. In case you want to build the image by yourself you have to clone this [repo](https://github.com/eltrino/diamantedesk-docker)
2. Run ```docker-compose up -d``` in that folder. Or ```docker-compose up --build``` if you want to build the image. This will run mysql and DiamanteDesk containers. 
3. Go to http://127.0.0.1:8015 You should see setup wizzard.
4. Run ```docker-compose stop``` to stop application and db containers.
5. Run ```docker-compose rm``` to delete application and db containers.

## Run DiamanteDesk Application with Docker CLI
1. Run DB container:

         docker run --name mysql57_diamante 
         -e MYSQL_ROOT_PASSWORD={set root password}
         -e MYSQL_DATABASE=diamantedesk 
         -e MYSQL_USER=diamantedesk
         -e MYSQL_PASSWORD={set user password} 
         -d mysql:5.7


2. Run application container and link DB:

         docker run 
         --name diamante
         -p 80:80 -p 8080:8080 
         --link mysql57_diamante:{DB alias}
         -d eltrino/diamantedesk

Set {DB alias} to any value you want and use it as DB hostname during installation.

# Notes
After each DiamanteDesk container we do some internal work in container, so application availability might be delayed for some seconds

As an application in this image is not installed, you have to proceed with web installer instructions.
The possibility to install application automatically is coming soon.