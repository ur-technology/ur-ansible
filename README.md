****THIS IS A WORK IN PROGRESS****

**ANSIBLE DEPLOYMENT AND MANAGEMENT PLAYBOOKS**

This file currently only applies to the Staging Miner Playbook.
The Staging Miner Deployment playbook is an Ansible Playbook that will allow you to deploy and continually manage the configuration of Miners in the UR Environment.

***USAGE***

It is very easy to use this playbook but please read this file in its entirety before attempting to deploy any new miners.

****Inventory****
We cannot use Ansible's inventory features with Digital Ocean.  Therefore, your inventory is defined in the playbook itself under the 'droplets' key.

This means that you should always keep the names of the miners you want to manage with this playbook in that list.

If you want to deploy new miners, simply add more miners to the droplets list and run the playbook. Any existing miners will only be checked to ensure their configuration is compliant.  Any new miners you have added to the list will be deployed and configured for you.

****Ansible Vault****
This playbook depends on the variables contained in the file group_vars/secrets.yml.  Make sure you have the password to that file and provide it to Ansible via Ansible Vault otherwise execution will fail.

****Execution****
Execution of the playbook is done like so:
```
ansible-playbook -i inventories/miners stage-miner.yml --ask-vault-pass
```
When prompted, enter the vault password.  Easy as that!  If you would like to get verbose output, simply add '-v' to the above command.  More v's give more detail.  For example: '-vvvvv'


***Copyright and Acceptable Use***
This playbook was developed by borrowing plenty of example code from the Ansible Documentation and other Ansible 
Playbooks. This playbook is the intellectual property of UR Technology. 
This playbook may only be used by authorized  personnel for authorized purposes only.  Failure to do so may result in 
a lot of legal trouble for you. If you are unsure whether or not you are an authorized user, you probably are not and
should stop using this playbook immediately. 

Developed by Jorge Vazquez mrjvazquez@gmail.com in the last hours of the year 2016.


