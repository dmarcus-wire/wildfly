# grab the environment variables
source vars.config

# build the container image
podman build --layers=false -t $IMAGE:v1.0-beta .
