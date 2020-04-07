# SKELETON PHP ( DOCKER )
PHP Docker template for new project
PHP-FPM + PHP-CLI + NGINX

All you need to do, is install the Docker

#STEP BY STEP for create new project:
 1. Install Docker `https://www.docker.com/get-started`
 2. Install Git `https://git-scm.com/downloads`
 3. Clone this repository $`git clone https://github.com/binarick/php-skeleton`
 4. (dont need) if you wont you can recreate 'composer.json' $`docker-compose run --rm php-cli composer init`
 5. Star initialisation $`make first-run` (composer install)
 6. Start project $`make up`
 Done !!! You project ready for work

#That you will get:
 1. php:7.4-fpm
 2. php:7.4-cli + composer
 3. nginx:alpine latest version

- Build for Production and Development
- Composer install on CLI only (FPM clear)
- Composer remove from production images
- Multistage build (super fast build for production)
- Small production image (only code, no composer)
- Mount you local SRC folder in FPM and CLI
- Developer dependencies will not be included in the image
- Optimise autoloader for production
- PHP-Opcache install for production
- dockerignore and gitignore files



# Makefile commandline help:
1. 'make up' - start project 
2. 'make init' - project initialization (for first run or rebuild)
3. 'make env-init' - local data initialization (composer local install)
4. 'make build-prod' - build production
5. 'make push-prod' -  push production
6. 'make deploy-prod' - deploy production

Examples
Production build: `REGISTRY_ADDRESS=registry IMAGE_TAG=0 make build-prod`

