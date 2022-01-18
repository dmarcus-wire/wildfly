# grab the environment variables
source vars.config

# remove the containers and image
podman rm -f $CONTAINER

# remove image name
podman rmi $IMAGE
