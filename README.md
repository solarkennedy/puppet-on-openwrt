Status:

OpenWrt package files are submitted for inclusion
Puppet/facter patches have been included in Trunk for inclusion in puppet 3.2
Binary packages have been made for early adopters (and me)
Why?

To scratch my own itch, and for Fun! 

How?

Downloads are here: http://download.xkyle.com/openwrt/

Because of the dependencies, it is probably easier to add the repo:

. /etc/openwrt_release
VERSION=`echo $DISTRIB_RELEASE | cut -f 1 -d -`
TARGET=`echo $DISTRIB_TARGET | cut -f 1 -d /`
LINE="src/gz puppet-packages http://download.xkyle.com/openwrt/$VERSION/$TARGET"
grep -q "$LINE" /etc/opkg.conf || echo "$LINE" >> /etc/opkg.conf
Then run:

opkg update; opkg install puppet
Help?

Running Puppet on OpenWrt is still far from perfect. There are going to be lots of bugs to be worked out. There are many use-cases / puppet modules / openwrt targets that I am not testing. If you think there is something wrong that could use fixing, feel free to open a Github Issue. I don't want to bother upstream OpenWrt or Puppet with questions until things are better tested.

To reiterate: Don't comment on the blog if something doesn't work. Open a Github Issue. And yes, things are going to be broken. Lets work together to fix them one at a time.
