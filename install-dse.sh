#!/bin/bash

DSA_EMAIL_ADDRESS=<Your DataStax Accademy email address>
DSA_PASSWORD=<Your DataStax Accedmy password>

# Escape '@' in email address with %40 URL encoded equivalent
ENCODED_DSA_EMAIL_ADDRESS=`echo "$DSA_EMAIL_ADDRESS" | sed 's/@/%40/'`

# Add the DataStax Yum repository
echo -e "[datastax]\nname=DataStax Repo for DataStax Enterprise\nbaseurl=https://$ENCODED_DSA_EMAIL_ADDRESS:$DSA_PASSWORD@rpm.datastax.com/enterprise\nenabled=1\ngpgcheck=1\n" > /etc/yum.repos.d/datastax.repo

# Import the DataStax Enterprise repository key
sudo rpm --import http://rpm.datastax.com/rpm/repo_key

# Install the DSE pacakge - latest DSE version and demoss
sudo yum -y install dse-full
sudo yum -y install dse-demos

# Enable Graph and Spark - disabled by default
sudo sed -i 's/GRAPH_ENABLED=0/GRAPH_ENABLED=1/' /etc/default/dse
sudo sed -i 's/SPARK_ENABLED=0/SPARK_ENABLED=1/' /etc/default/dse

# IP address of eth1
IP_ADDRESS=`hostname -I | cut -d ' ' -f 2`

# Update Cassandra configuration
sudo sed -i "s/localhost/$IP_ADDRESS/" /etc/dse/cassandra/cassandra.yaml 
sudo sed -i "s/127\.0\.0\.1/$IP_ADDRESS/" /etc/dse/cassandra/cassandra.yaml 

# If DataStax Enterprise is not already running (single node cluster only):
sudo service dse restart

sleep 10

# Verify that DataStax Enterprise is running:
nodetool status

# Get DSE Studio - as vagrant user
chown vagrant:vagrant cust-examples.tar.gz
sudo -u vagrant bash << EOF
curl -L --user $DSA_EMAIL_ADDRESS:$DSA_PASSWORD http://downloads.datastax.com/datastax-studio/datastax-studio.tar.gz | tar xz

sleep 5

# Create Customer Graph
sudo sed -i "s/localhost/$IP_ADDRESS/" /etc/dse/graph/gremlin-console/conf/remote.yaml
echo -e "system.graph('CustGraph').create()\n:quit" | dse gremlin-console

# Update DSE Studio configuration
sed -i "s/localhost/$IP_ADDRESS/" datastax-studio-*/conf/configuration.yaml

# Add Customer Graph example notebook
tar -zxvf cust-examples.tar.gz
rm cust-examples.tar.gz

# Start DSE Studio
nohup datastax-studio-*/bin/server.sh &
EOF
