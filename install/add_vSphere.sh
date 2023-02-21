#!/bin/bash

influxPort=8086
telegrafPort=8125
i=0
cd /usr/local/bin/install/setup/setup_vSphere
for dir in */; do
    i=$((i+1))
done
mkdir /usr/local/bin/install/setup/setup_vSphere/Monitor-$((i-1))
cp -R configFile /usr/local/bin/install/setup/setup_vSphere/Monitor-$((i-1))
cp docker-compose.yml /usr/local/bin/install/setup/setup_vSphere/Monitor-$((i-1))

echo -------------------------------
echo "  Telegraf Config Monitor-$((i-1))"
read -p 'vSphere IP: ' ip_vSphere
read -p 'Host IP: ' ip_host
read -p 'Username vSphere: ' user_vSphere
read -p 'Password vSphere: ' pass_vSphere
echo -------------------------------
sed -i -e 's/$ip/'$ip_vSphere'/' -e 's/$portip/'$(($influxPort+$((i-1))))'/' -e 's/$host/'$ip_host'/' -e 's/$user/'$user_vSphere'/' -e 's/$pass/'$pass_vSphere'/' /usr/local/bin/install/setup/setup_vSphere/Monitor-$((i-1))/configFile/telegraf.conf
sed -i -e 's/$ip/'$ip_vSphere'/' -e 's/$influx/'$(($influxPort+$((i-1))))'/' -e 's/$telegraf/'$(($telegrafPort+$((i-1))))'/' -e 's/$num/'$((i-1))'/' /usr/local/bin/install/setup/setup_vSphere/Monitor-$((i-1))/docker-compose.yml
cd /usr/local/bin/install/setup/setup_vSphere/Monitor-$((i-1))
docker-compose up -d
cd ~
echo -------------------------------
docker ps -a
echo -------------------------------

