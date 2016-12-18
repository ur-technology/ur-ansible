#!/bin/bash

###############################################################
#  DEPLOYMENT SCRIPT FOR DIGITAL OCEAN DEVELOPMENT TORONTO 1  #
#  UR TECHNOLOGY STACK.  DEVELOPED FOR DEVOPS AND DEVELOPERS  #
###############################################################

# This script will deploy a set of QUEUES for development.
# Please note that this only deploys the Droplets.  You must
# configure the Droplets after deployment.

# VARIABLES
DO_IMAGE_SIZE=2gb
DO_IMAGE_SLUG=21543639
DO_REGION=tor1
DO_SSH_KEYS=4871217
UR_QUEUE1_NAME=queue1-tor1-do.test.ur.technology
DO_QUEUE_IP1=159.203.50.219

# DEPLOYMENT OF QUEUES
echo "Deploying "$UR_QUEUE1_NAME"..."
DO_QUEUE_ID1=`doctl compute droplet create $UR_QUEUE1_NAME --size $DO_IMAGE_SIZE --image $DO_IMAGE_SLUG --region $DO_REGION --ssh-keys $DO_SSH_KEYS --wait --format ID --no-header`
echo "Done."

# ASSIGNMENT OF FLOATING IP
echo "Now assigning floating IP to "$UR_QUEUE1_NAME" with ID "$DO_QUEUE_ID1"..."
doctl compute floating-ip-action assign $DO_QUEUE_IP1 $DO_QUEUE_ID1 --wait --no-header
echo "Done."

# SETTING OF VARIOUS OPTIONS
echo "Finished QUEUE deployment.  Enjoy."



