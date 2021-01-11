# Install facilities
apt install --yes --force-yes kamailio*
apt install rtpproxy

# Import virtual root
cp -rv /vroot/* /

systemctl stop rtpproxy
pkill rtpproxy
rtpproxy -F -u vagrant -s udp:127.0.0.1:7722 -l $MEDIA_PROXY_IP
systemctl restart kamailio
