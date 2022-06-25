#
printf "installing docker..."
apt-get install docker
#
printf "installing docker compose...\n"
DOCKER_COMPOSE_DESTINATION=/usr/local/bin/docker-compose
DOCKER_COMPOSE_VERSION=1.29.0
curl -L https://github.com/docker/compose/releases/download/$\{DOCKER_COMPOSE_VERSION\}/docker-compose-$\(uname -s)-$(uname -m) -o $DOCKER_COMPOSE_DESTINATION
#