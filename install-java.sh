#!/bin/bash

VERSION=111

# Prepare for installation
sudo yum -y update
sudo yum -y install wget

# Get JDK RPM
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u$VERSION-b14/jdk-8u$VERSION-linux-x64.rpm"
sudo yum -y localinstall jdk-8u$VERSION-linux-x64.rpm 

# Show Java is running
java -fullversion

# Clean up
rm jdk-8u$VERSION-linux-x64.rpm


