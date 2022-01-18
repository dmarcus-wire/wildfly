# Containerfile extending the jboss-base with WildFly server

# set the base container image to extend; requires the tag 
FROM docker.io/jboss/base-jdk:11

# set who will maintain this container image
MAINTAINER Your Name 'your@email.com`

# set environment variables for the jboss home dir and wildfly version
ENV JBOSS_HOME /opt/jboss/wildfly 
ENV WILDFLY_VERSION 26.0.0.Final

# in the container
# change to the root user
USER root

# add and decompress the tar to the default working directory /opt/jboss
ADD wildfly-${WILDFLY_VERSION}.tar.gz .

# move the WildFly install to /opt/jboss/wildfly
RUN mv wildfly-$WILDFLY_VERSION ${JBOSS_HOME} \ 

  # change the ownership of /opt/jboss/wildfly to jboss
   && chown -R jboss:0 ${JBOSS_HOME} \
        
  # change the permissions to /opt/jboss/wildfly
   && chmod -R g+rw ${JBOSS_HOME}

# ensure signals are forwarded to the JVM process for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

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
