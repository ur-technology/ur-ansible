****THIS IS A WORK IN PROGRESS****

**ANSIBLE DEPLOYMENT AND MANAGEMENT PLAYBOOKS**

As of this writing, you can use these playbooks to deploy any number of miners 
to Digital Ocean.  Your deployment will only be constrained by the number of 
Droplets your account is allowed to deploy.  In the case of UR Technoogy, the 
maximum number of total Droplets is 40 (this includes existing Droplets).

***USAGE***

There are three parts to using these playbooks.  The process becomes second
nature after doing this a few times.  Basically, you need to deploy the 
Droplets first - don't worry, you will do that with Ansible. With your Droplets
deployed, you create an inventory file so that Ansible knows how to connect to
your Droplets.  And finally, with your inventory file ready to go, you simply 
execute the Ansible playbook.

****Deployment****
1. Edit the deployment specification found at group_vars/deployment.yml and add 
   the desired Droplet names to the droplets variable like so:
````
droplets:
  - miner3.ur.technology
  - miner4.ur.technology
````
   You can add as many Droplets as you want up to your Digital Ocean limit. 
   As this is a YML file, you must be careful with the formatting or your 
   deployment will fail.

   Now run the deployment playbook from the top level playbook directory like
   so:
````
ansible-playbook -i inventories/digitalocean deploy-droplets.yml \
--ask-vault-pass
````
   The above command will prompt you for the vault password and execute your 
   deployment.

2. Now that you have deployed your Droplets, you need to edit or create an
   inventory file so that Ansible knows how to connect to your Droplets.  It is
   possible to do all of this automatically with a Dynamic Inventory script, 
   but the Digital Ocean implementation is still buggy so we do it all by hand.
   For this example, since we only deployed miners in 1. we are only going to 
   edit the miner inventory. You do that like so:
````
nano inventories/miner
````
   In this file, you want to tell Ansible the names of the hosts, their IP
   addresses, and the keyfile you want it to use when connecting to your
   Droplets.  This is done like so:
````
[miners]
miner3.ur.technology ansible_host=138.197.131.204 ansible_user=root \ 
ansible_ssh_private_key_file=/root/.ssh/automator-root-rsa
miner4.ur.technology ansible_host=138.197.131.157 ansible_user=root \
ansible_ssh_private_key_file=/root/.ssh/automator-root-rsa 
````
   Note that the above are only 2 lines and the \ is not part of the line,
   it is only shown to let you know the next line is a continuation.
   This gives us an inventory file that has the names of the Droplets, their
   IP addresses, and the key we want Ansible to use.  Save the file.

3. We are now ready to execute our main configuration playbook. This is done
   very much like we did above in 1.  To execute configuration, issue the 
   following command:
````
ansible-playbook -i inventories/miners stage-miners.yml --ask-vault-pass
````
   Ansible will ask for the vault password and apply the configuration to your
   Droplets.  That is all there is to it! 


****Ansible Vault****
This playbook depends on sensitive information  contained in the file 
group_vars/secrets.yml.  Make sure you have the password to that file and
provide it to Ansible via --ask-vault-pass otherwise execution will fail.

You can always view the contents of any Ansible Vault file by decrypting it 
first with the following command:
````
ansible-vault decrypt <path/to/file>
````
Ansible Vault will ask for the password and proceed to decrypt the file. You
can also do the opposite by running:
````
ansible-vault encrypt <path/to/file>
````
Ansible Vault will ask for the encryption password only ONCE, so be careful.

**IMPORTANT NOTES**
***SSH KEYS***
Change  do_ssh_key_name, do_ssh_key_file, and do_ssh_key_id variables in 
roles/do-deploy/defaults/main.yml if you will be running these playbooks from
your workstation otherwise you will overwrite any keys that have been uploaded
by this script to DigitalOcean. Not a good thing.

***AUTOMATOR.UR.TECHNOLOGY****
The Droplet accessible at automator.ur.technology is readily configured to run
Ansible and it is recommended you execute these playbooks from it.  If you use
the automator, you don't have to change the variables mentioned in the previous
paragraph.


**CREDITS**
Developed by Jorge Vazquez mrjvazquez@gmail.com over the course of a couple of
months in 2016 and 2017.


