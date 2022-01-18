# Containerfile extending the jboss-base with WildFly server

# set the base container image to extend; requires the tag 
FROM docker.io/jboss/base-jdk:11

# set who will maintain this container image
MAINTAINER Your Name 'your@email.com'

# set environment variables for the jboss home dir and wildfly version
ENV JBOSS_HOME="/opt/jboss/wildfly" \
WILDFLY_VERSION="26.0.0.Final" \
WILDFLY_SRC="https://github.com/wildfly/wildfly/releases/download/26.0.0.Final/wildfly-26.0.0.Final.tar.gz" \
LAUNCH_JBOSS_IN_BACKGROUND="true"

# switch to root user
USER root

# add and decompress the tar to the default working directory /opt/jboss
ADD ${WILDFLY_SRC} .

# move the WildFly install to /opt/jboss/wildfly
RUN tar xf wildfly-$WILDFLY_VERSION.tar.gz \
  
  # move the tar file from /opt/jboss to /opt/jboss/wildfly 
   && mv wildfly-$WILDFLY_VERSION ${JBOSS_HOME} \ 

  # remove the tar file to reclaim space
   && rm wildfly-$WILDFLY_VERSION.tar.gz \

  # change the ownership of /opt/jboss/wildfly to jboss
   && chown -R jboss:0 ${JBOSS_HOME} \
        
  # change the permissions to /opt/jboss/wildfly
   && chmod -R g+rw ${JBOSS_HOME}

# change to jboss user
USER jboss

# set the working directory to jboss home for the following instructions and container launch
WORKDIR ${JBOSS_HOME}

# use the WildFly script (relative from the working dir) to create an admin user to access the admin console
RUN ./bin/add-user.sh admin Admin#70365 --silent

# set metadata for the ports the container listens 8080 and 9990 for admin console
EXPOSE 8080 9990

# use WildFly script to boot in standalone mode and bind all interfaces
CMD ["./bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
