# grab the environment variables
source vars.config

# remove the containers and image
podman rm -f $CONTAINER && podman rmi $IMAGE
