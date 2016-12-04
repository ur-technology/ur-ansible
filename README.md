#**THIS IS A WORK IN PROGRESS**

# ur-ansible
##Description
ur-ansible is a set of Ansible Playbooks that allow for the instant deployment of UR Technology cryptocurrency environments as well as full configuration management of existing computing assets.

Currently, this version only supports the Digital Ocean cloud but there are plans to build Vagrant support so that you could easily deploy an environment in your local machine using VirtualBox.

There are three main playbooks that can be used:
- deploy-dev.yml
- deploy-test.yml
- deploy-prod.yml

These playbooks deploy and manage the respective environments (dev, test, and production) on the Digital Ocean cloud.  The playbooks are human readable and can easily be customized to deploy alternate environments.

##Usage
**NOTE:** Usage of these playbooks is extremely easy but there is one pre-requisite:  your environment must contain the DO_API_TOKEN variable containing a valid Digital Ocean API v2 token. The variable should be set manually, once per session where you intend to run the playbooks.  **Setting this variable automatically in your .bashrc file is discouraged.** Please see the DevOps thread in Slack for the correct API key to use.

Deploying the test environment is as easy as:
````
# ansible-playbook -i inventories/test/hosts deploy-test.yml #Deploys the test environment
````
This will setup 2 bootnodes, 1 explorer, 1 queue, 1 transaction relay, and 2 miners in Digital Ocean, all ready to go. 

Suppose you only want to launch the bootnodes in the test environment in the Toronto1 region of Digital Ocean (currently, all computing assets are deployed only in the Toronto1 Digital Ocean region).  Then you can issue:
````
# ansible-playbook -i inventory/test/hosts deploy-test.yml --limit tor1-bootnode #Deploys the bootnodes in the test environment
````
This will set up bootnode1 and bootnode2 but what if they already exist?  If the bootnodes are already deployed, Ansible will make sure that they conform to the configuration described in the playbook! What if you wanted 2 additional bootnodes?  Yes, you can. Simply edit the inventory file at inventory/test/hosts and add two more node names to the list of bootnodes and run the previous command.  That is all there is to it!

