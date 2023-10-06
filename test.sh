#!/bin/bash
while true
do 
	echo "Start new iteration" > test.log
	rm -fr /tmp/kraft*
	UUID=$(cat /vagrant/uuid)
	rm -fr /home/vagrant/kafka/logs/*
	echo "Start UUID $UUID" > test.log
	/home/vagrant/kafka/bin/kafka-storage.sh format -t $UUID -c /home/vagrant/kafka/config/kraft/server.properties > server.log
	/home/vagrant/kafka/bin/kafka-server-start.sh /home/vagrant/kafka/config/kraft/server.properties > server.log
       	sleep 1
done
