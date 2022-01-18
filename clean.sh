# grab the environment variables
source vars.config

# remove the containers and image
podman rm -f $CONTAINER

# remove image name
podman rmi $IMAGE

# remove tar files
rm wildfly-26.0.0.Final.tar.gz
