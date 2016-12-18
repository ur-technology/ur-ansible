#!/bin/bash

###############################################################
#  DEPLOYMENT SCRIPT FOR DIGITAL OCEAN DEVELOPMENT TORONTO 1  #
#  UR TECHNOLOGY STACK.  DEVELOPED FOR DEVOPS AND DEVELOPERS  #
###############################################################

# This script will deploy a set of EXPLORERs for development.
# Please note that this only deploys the Droplets.  You must
# configure the Droplets after deployment.

# VARIABLES
DO_IMAGE_SIZE=2gb
DO_IMAGE_SLUG=21543639
DO_REGION=tor1
DO_SSH_KEYS=4871217
UR_EXPLORER1_NAME=explorer1-tor1-do.test.ur.technology
DO_EXPLORER_IP1=159.203.50.220

# DEPLOYMENT OF EXPLORERS
echo "Deploying "$UR_EXPLORER1_NAME"..."
DO_EXPLORER_ID1=`doctl compute droplet create $UR_EXPLORER1_NAME --size $DO_IMAGE_SIZE --image $DO_IMAGE_SLUG --region $DO_REGION --ssh-keys $DO_SSH_KEYS --wait --format ID --no-header`
echo "Done."

# ASSIGNMENT OF FLOATING IP
echo "Now assigning floating IP to "$UR_EXPLORER1_NAME" with ID "$DO_EXPLORER_ID1"..."
doctl compute floating-ip-action assign $DO_EXPLORER_IP1 $DO_EXPLORER_ID1 --wait --no-header
echo "Done."

# SETTING OF VARIOUS OPTIONS
echo "Finished Explorer deployment.  Enjoy."



