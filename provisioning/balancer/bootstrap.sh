# Install facilities
apt install --yes --force-yes kamailio*

# Import virtual root
cp -rv /vroot/* /

# Setup db
yes n | /usr/sbin/kamdbctl create
systemctl restart kamailio

