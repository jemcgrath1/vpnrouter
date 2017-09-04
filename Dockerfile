FROM alpine:latest
MAINTAINER jemcgrath1

#Set Versioning and Labels
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/jemcgrath1/vpnrouter.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"

# environment variables
ENV OPENVPN_USERNAME=**None** \
    OPENVPN_PASSWORD=**None** \
    # This is the full name (XYZ.ovpn) of the ovpn file to use)
    OPENVPN_CONFIG_FILE=**None**

# Install the latest available OpenVPN, bash and tzdata and remove the cached install files
RUN apk add --update --no-cache \
 openvpn \
 bash \
 tzdata && \

# make our folders
mkdir -p \
	#/app \
	/config && \
	#/defaults && \

# clean up
#pk del --purge build-dependencies
rm -rf \
/tmp/*

COPY openvpn.sh /openvpn.sh
#Ensure that there are execute permissions on the openvpn.sh script
RUN chmod +x /openvpn.sh

# Defualt entrypoint and run command
ENTRYPOINT ["/openvpn.sh"]

#Volumes and ports
VOLUME /vpn
#No ports required to be exposed
#Exposed N/A
