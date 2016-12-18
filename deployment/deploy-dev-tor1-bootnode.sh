#!/bin/bash

###############################################################
#  DEPLOYMENT SCRIPT FOR DIGITAL OCEAN DEVELOPMENT TORONTO 1  #
#  UR TECHNOLOGY STACK.  DEVELOPED FOR DEVOPS AND DEVELOPERS  #
###############################################################

# This script will deploy a set of bootnodes for development.
# Please note that this only deploys the Droplets.  You must
# configure the Droplets after deployment.

# VARIABLES
DO_IMAGE_SIZE=2gb
DO_IMAGE_SLUG=21543639
DO_REGION=tor1
DO_SSH_KEYS=4871217
UR_BOOTNODE1_NAME=boot1-tor1-do.test.ur.technology
UR_BOOTNODE2_NAME=boot2-tor1-do.test.ur.technology
DO_BOOTNODE_IP1=159.203.51.23
DO_BOOTNODE_IP2=159.203.51.24
DO_BOOTNODE_ID1=34747824
DO_BOOTNODE_ID2=34747825


# DEPLOYMENT OF BOOTNODES
echo "Deploying Bootnode 1..."
doctl compute droplet create $UR_BOOTNODE1_NAME --size $DO_IMAGE_SIZE --image $DO_IMAGE_SLUG --region $DO_REGION --ssh-keys $DO_SSH_KEYS
echo "Done."
echo "Deploying Bootnode 2..."
doctl compute droplet create $UR_BOOTNODE2_NAME --size $DO_IMAGE_SIZE --image $DO_IMAGE_SLUG --region $DO_REGION --ssh-keys $DO_SSH_KEYS
echo "Done."

# ASSIGNMENT OF FLOATING IP
echo "Now assigning floating IP to Bootnode 1..."
doctl compute floating-ip-action assign $DO_BOOTNODE_IP1 $DO_BOOTNODE_ID1
echo "Done."
echo "Now assigning floating IP to Bootnode 2..."
doctl compute floating-ip-action assign $DO_BOOTNODE_IP2 $DO_BOOTNODE_ID2
echo "Done."

# SETTING OF VARIOUS OPTIONS
echo "Finishing deployment of Bootnodes..."


