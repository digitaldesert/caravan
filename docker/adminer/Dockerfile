FROM adminer:4

LABEL maintainer="xercole <support.digitaldesert.ca>"

# Add volume for sessions to allow session persistence
VOLUME /sessions

#####################################
# SQL SERVER:
#####################################
USER root

USER adminer

# We expose Adminer on port 8080 (Adminer's default)
EXPOSE 8080
