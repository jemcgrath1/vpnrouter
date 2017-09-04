#!/bin/sh

set -o nounset                              # Treat unset variables as an error

dir="/vpn"
#file="$dir/.firewall"

# Warn if openvpn credentials are not set
if [ "${OPENVPN_USERNAME}" = "**None**" ] || [ "${OPENVPN_PASSWORD}" = "**None**" ] ; then
 echo "OpenVPN credentials not set. Exiting."
 exit 1
else
  ##Write the openvpn credentials into a text file for auto connect for ovpn file
  echo "Setting OPENVPN credentials..."
  #mkdir -p /config -added to docker file
  echo $OPENVPN_USERNAME > /config/openvpn-credentials.txt
  echo $OPENVPN_PASSWORD >> /config/openvpn-credentials.txt
  #ensure the permissions are restricted on the credentials file
  chmod 600 /config/openvpn-credentials.txt
fi

##Connect to VPN using the ovpn file located in $dir
    /usr/sbin/openvpn --cd /etc/openvpn --config $dir/$OPENVPN_CONFIG_FILE
    #exec sg vpn -c "openvpn --config $dir/$OPENVPN_CONFIG_FILE"
#fi
