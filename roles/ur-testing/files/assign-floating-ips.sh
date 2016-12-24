#!/bin/bash

###############################################################
#  DEPLOYMENT SCRIPT FOR DIGITAL OCEAN DEVELOPMENT TORONTO 1  #
#  UR TECHNOLOGY STACK.  DEVELOPED BY JORGE VAZQUEZ.          #
###############################################################

# This script will assign floating IPs to the stack.  It is
# meant to be called from within an Ansible Playbook.

# Here we define what our hosts are called
UR_BOOTNODE1_NAME=boot1-tor1-do.test.ur.technology
UR_BOOTNODE2_NAME=boot2-tor1-do.test.ur.technology
UR_EXPLORER1_NAME=explorer1-tor1-do.test.ur.technology
UR_QUEUE1_NAME=queue1-tor1-do.test.ur.technology
UR_RELAY1_NAME=relay1-tor1-do.test.ur.techology
UR_MINER1_NAME=miner1-tor1-do.test.ur.technology

# Here we define what IPs will be assigned to the hosts
# Please note that you should have enough floating IPs
# defined here to correspond to the hosts listed above.
# The floating IPs should already exist.
DO_BOOTNODE_IP1=159.203.51.23
DO_BOOTNODE_IP2=159.203.51.24
DO_EXPLORER_IP1=159.203.50.220
DO_QUEUE_IP1=159.203.50.219
DO_RELAY_IP1=159.203.50.206
DO_MINER_IP1=

# And now we assign the IPs
echo "Now assigning floating IP to "$UR_BOOTNODE1_NAME" with ID "$DO_BOOTNODE_ID1"..."
doctl compute floating-ip-action assign $DO_BOOTNODE_IP1 $DO_BOOTNODE_ID1  --no-header
echo "Done."
echo "Now assigning floating IP to "$UR_BOOTNODE2_NAME" with ID "$DO_BOOTNODE_ID2"..."
doctl compute floating-ip-action assign $DO_BOOTNODE_IP2 $DO_BOOTNODE_ID2 --no-header
echo "Done."
echo "Now assigning floating IP to "$UR_EXPLORER1_NAME" with ID "$DO_EXPLORER_ID1"..."
doctl compute floating-ip-action assign $DO_EXPLORER_IP1 $DO_EXPLORER_ID1 --no-header
echo "Done."
echo "Now assigning floating IP to "$UR_QUEUE1_NAME" with ID "$DO_QUEUE_ID1"..."
doctl compute floating-ip-action assign $DO_QUEUE_IP1 $DO_QUEUE_ID1  --no-header
echo "Done."
echo "Now assigning floating IP to "$UR_RELAY1_NAME" with ID "$DO_RELAY_ID1"..."
doctl compute floating-ip-action assign $DO_RELAY_IP1 $DO_RELAY_ID1 --no-header
echo "Done."

# We are done!!!
echo "Finished Assigning Floating IPs.  Enjoy."
