FROM alpine:latest
MAINTAINER jemcgrath1

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="jemcgrath1/vpnrouter version:- ${VERSION} Build-date:- ${BUILD_DATE}"

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
