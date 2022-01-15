# grab the environment variables
source vars.config

# run the container
podman run -d --name $CONTAINER -p 8080:8080 -p 9990:9990 $IMAGE:v1.0-beta
