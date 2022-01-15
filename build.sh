# grab the environment variables
source vars.config

# grab the wildfly server
wget https://github.com/wildfly/wildfly/releases/download/26.0.0.Final/wildfly-26.0.0.Final.tar.gz

# build the container image
podman build --layers=false -t $IMAGE:v1.0-beta .
