up: dc-up
init: dc-down dc-pull dc-build dc-up env-init
first-run: env-init

# DEVELOPMENT
dc-up:
	docker-compose up -d
dc-down:
	docker-compose down --remove-orphans
dc-pull:
	docker-compose pull
dc-build:
	docker-compose build

# COMPOSER
env-first-init:
	docker-compose run --rm php-cli composer install
	#add migration

# Every day start init
env-init:
	docker-compose run --rm php-cli composer update

# PRODUCTION
#cli command example: REGISTRY_ADDRESS=registry IMAGE_TAG=0 make build-prod
build-prod:
	docker build --file=project/docker/production/nginx.dockerfile --tag ${REGISTRY_ADDRESS}/nginx:${IMAGE_TAG} project
	docker build --file=project/docker/production/fpm.dockerfile --tag ${REGISTRY_ADDRESS}/php-fpm:${IMAGE_TAG} project
	docker build --file=project/docker/production/cli.dockerfile --tag ${REGISTRY_ADDRESS}/php-cli:${IMAGE_TAG} project

push-prod:
	docker push ${REGISTRY_ADDRESS}/nginx:${IMAGE_TAG}
	docker push ${REGISTRY_ADDRESS}/php-fpm:${IMAGE_TAG}
	docker push ${REGISTRY_ADDRESS}/php-cli:${IMAGE_TAG}

deploy-prod:
	ssh ${PRODUCTION_HOST} -p ${PRODUCTION_PORT} 'rm -rf docker-compose.yaml .env'
	scp ${PRODUCTION_PORT} docker-compose-production.yaml ${PRODUCTION_HOST}.docker-compose.yaml
	ssh ${PRODUCTION_HOST} -p ${PRODUCTION_PORT} 'echo "REGISTRY_ADDRESS=${REGISTRY_ADDRESS}" >> .env'
	ssh ${PRODUCTION_HOST} -p ${PRODUCTION_PORT} 'echo "IMAGE_TAG=${IMAGE_TAG}" >> .env'
	ssh ${PRODUCTION_HOST} -p ${PRODUCTION_PORT} 'docker-compose pull'
	ssh ${PRODUCTION_HOST} -p ${PRODUCTION_PORT} 'docker-compose --build -d'
