# DataStax Enterprise (DSE) Graph Demo

This demo uses Vagrant to create a VM, install DSE Graph and configure and start a Customer Graph.

## Setup

### Requirements
- VirtualBox
- Vagrant (to build the VM)
- A DataStax Accademy (DA) account

### Installation
Change the install-dse.sh script to include the email address and password you use for DataStax Accademy.
Run the command 'vagrant up'. This will create the VM, install Java and DSE, and configure and start the demo

## Running the demo
1. Open the URL http://192.168.56.211:9091/ in a browser. This will take you to the DataStax Studio home page.
2. Click on the CustomerNotbook notebook
3. When the CustomerNotebook appears, scroll down and click on the 'Run' button (top right) for each of the Gremlin code panels in turn. This will create the Customer Graph schema, load sample data and run various queries
