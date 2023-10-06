#!/bin/bash

set +x

export DEBIAN_FRONTEND=noninteractive

KAFKA_CONFIG="/home/vagrant/kafka/config/kraft/server.properties"
KAFKA_LOG="/home/vagrant/kafka_server.log"
sed -i "/$HOSTNAME/d" /etc/hosts

ID=$(echo $HOSTNAME | tr -dc '0-9')
cat /vagrant/hosts >> /etc/hosts


sudo apt-get update
sudo apt-get install openjdk-17-jre -y
# to avoid and reuse downloaded tar ball
pushd /vagrant
wget --continue --show-progress --https-only --timestamping https://downloads.apache.org/kafka/3.5.1/kafka_2.13-3.5.1.tgz
popd
cp /vagrant/kafka_2.13-3.5.1.tgz .
tar -xvf kafka_2.13-3.5.1.tgz -C /home/vagrant
mv /home/vagrant/kafka{_2.13-3.5.1,}
echo "PATH=$PATH:/home/vagrant/kafka/bin" > /home/vagrant/.bashrc
if [ $HOSTNAME == "kafka1" ]
then
	UUID=$(/home/vagrant/kafka/bin/kafka-storage.sh random-uuid)
	echo $UUID > /vagrant/uuid
else
	UUID=$(cat /vagrant/uuid)
fi
echo $UUID
sed -i "s/node.id=./node.id=$ID/g" $KAFKA_CONFIG
sed -i "s#controller.quorum.voters=.*#controller.quorum.voters=1@kafka1:9093,2@kafka2:9093,3@kafka3:9093#g" $KAFKA_CONFIG
sed -i "s#^listeners=PLAINTEXT.*#listeners=PLAINTEXT://${HOSTNAME}:9092,CONTROLLER://${HOSTNAME}:9093#g" $KAFKA_CONFIG
sed -i "s#^advertised.listeners=.*#advertised.listeners=PLAINTEXT://${HOSTNAME}:9092#g" $KAFKA_CONFIG
sudo chown -R vagrant:vagrant /home/vagrant/kafka
sudo -u vagrant /home/vagrant/kafka/bin/kafka-storage.sh format -t $UUID -c $KAFKA_CONFIG
#sudo -u vagrant screen -d -m nohup  /vagrant/test.sh
sudo -u vagrant nohup /vagrant/test.sh &
