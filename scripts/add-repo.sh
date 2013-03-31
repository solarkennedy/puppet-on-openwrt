. /etc/openwrt_release
VERSION=`echo $DISTRIB_RELEASE | cut -f 1 -d -`
TARGET=`echo $DISTRIB_TARGET | cut -f 1 -d /`
LINE="src/gz puppet-packages http://download.xkyle.com/openwrt/$VERSION/$TARGET"
grep -q "$LINE" /etc/opkg.conf || echo "$LINE" >> /etc/opkg.conf
