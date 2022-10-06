## Drupal 

# prerequisites

- Docker
- Docker compose

# How to use

If you have already created project, just copy it to dpupal-data folder
If you have already mysql data, just copy that to mysql-data folder and enable volume in docker-compose by uncommenting that, also you can copy your database sql code to setup.sql and with this code database will be created


open .env file and fill the mysql credentials, then run

`docker-compose up -d`

to run complete project with mysql


## Creating image

to create image from Dockerfile, just need to run 

`docker build -t imagename:version .`


