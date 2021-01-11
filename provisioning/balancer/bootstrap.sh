# Install facilities
apt install --yes --force-yes kamailio*

# Import virtual root
cp -rv /vroot/* /

# Setup db
yes n | /usr/sbin/kamdbctl create

kamctl dispatcher add 1 sip:$MEDIA_PROXY_IP:$MEDIA_PROXY_PORT 0 0 '' 'Media proxy'

systemctl restart kamailio
