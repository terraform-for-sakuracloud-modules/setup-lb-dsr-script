#!/bin/bash
# @sacloud-once
# @sacloud-desc-begin
# ロードバランス対象のサーバの設定のためのスクリプトです。
# このスクリプトは、CentOS6.XもしくはScientific Linux6.Xでのみ動作します。
# @sacloud-desc-end
# @sacloud-require-archive distro-centos distro-ver-6.*
# @sacloud-require-archive distro-sl distro-ver-6.*

PARA1=${vip}
PARA2="net.ipv4.conf.all.arp_ignore = 1"
PARA3="net.ipv4.conf.all.arp_announce = 2"
PARA4="DEVICE=lo:0"
PARA5="IPADDR="$PARA1
PARA6="NETMASK=255.255.255.255"

cp --backup /etc/sysctl.conf /tmp/ || exit 1

echo $PARA2 >> /etc/sysctl.conf
echo $PARA3 >> /etc/sysctl.conf
sysctl -p 1>/dev/null

cp --backup /etc/sysconfig/network-scripts/ifcfg-lo:0 /tmp/ 2>/dev/null

touch /etc/sysconfig/network-scripts/ifcfg-lo:0
echo $PARA4 > /etc/sysconfig/network-scripts/ifcfg-lo:0
echo $PARA5 >> /etc/sysconfig/network-scripts/ifcfg-lo:0
echo $PARA6 >> /etc/sysconfig/network-scripts/ifcfg-lo:0

ifup lo:0 || exit 1

exit 0