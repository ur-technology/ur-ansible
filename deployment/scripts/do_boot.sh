#!/bin/bash
# www1 do_size_slug="1gb" do_region_slug="nyc1" do_image=12345

DEFAULT_SIZE="512mb" # 512mb (override with do_size_slug)
DEFAULT_REGION="tor1" # tor1 (override with do_region_slug)
DEFAULT_IMAGE="21132217" # Ubuntu 14.10 x64 (override with do_image_slug)
DEFAULT_KEY=4871217 # SSH key, change this ! (override with do_key)

LOCALHOST_ENTRY="localhost ansible_python_interpreter=/usr/bin/python2" 

STATE=${2:-"present"}

COMMAND="state=$STATE command=droplet private_networking=yes unique_name=yes"

function bail_out {
  echo -e "\033[0;31m"
  echo $1
  echo -e "\033[0m"
  echo -e "Usage: $0 <inventory_directory> [present|deleted]\n"
  echo -e "\tinventory_directory: the directory containing the inventory goal (compulsory)"
  echo -e "\tpresent: the droplet will be created if it doesn't exist (default)"
  echo -e "\tdeleted: the droplet will be destroyed if it exists\n"
  exit 1
}

INVENTORY=$1
[[ ! -d "$INVENTORY" ]]  && bail_out "Inventory does not exist, is not a directory, or is not set"
[[ -z "$DO_API_TOKEN" ]] && bail_out "DO_API_TOKEN not set. Please visit https://cloud.digitalocean.com/settings/applications"

JQ=`which jq` || bail_out "Unable to find required binary 'jq'. Please install it first (http://stedolan.github.io/jq/)"

HOSTS=$(ansible -i $1 --list-hosts all | awk '{ print $1 }' | tr '\n' ' ')

rm ${INVENTORY}/generated > /dev/null 2>&1

TEMP_INVENTORY=$(mktemp)
echo Creating temporary inventory in ${TEMP_INVENTORY}
echo ${LOCALHOST} > ${TEMP_INVENTORY}

# Create droplets in //
for i in ${HOSTS}; do 
  SIZE=$(grep $i $1/hosts | grep do_size_slug | sed -e 's/.*do_size_slug=\(\d*\)/\1/')
  REGION=$(grep $i $1/hosts | grep do_region_slug | sed -e 's/.*do_region_slug=\(\d*\)/\1/')
  IMAGE=$(grep $i $1/hosts | grep do_image_slug | sed -e 's/.*do_image_slug=\(\d*\)/\1/')
  KEY=$(grep $i $1/hosts | grep do_key | sed -e 's/.*do_key=\(\d*\)/\1/')

  SIZE=${SIZE:-$DEFAULT_SIZE}
  REGION=${REGION:-$DEFAULT_REGION}
  IMAGE=${IMAGE:-$DEFAULT_IMAGE}
  KEY=${KEY:-$DEFAULT_KEY}

  if [ "${STATE}" == "present" ]; then
    echo "Creating $i of size $SIZE using image $IMAGE in region $REGION with key $KEY"
  else
    echo "Deleting $i"
  fi
  # echo " => $COMMAND name=$i size_id=$SIZE image_id=$IMAGE region_id=$REGION ssh_key_ids=$KEY"
  ansible localhost -c local -i ${TEMP_INVENTORY} -m digital_ocean \
    -a "$COMMAND name=$i size_id=$SIZE image_id=$IMAGE region_id=$REGION ssh_key_ids=$KEY" &
done

wait

if [ "${STATE}" == "present" ]; then
  for i in ${HOSTS}; do 
    echo Checking droplet $i
    IP=$(ansible localhost -c local -i $TEMP_INVENTORY -m digital_ocean -a "state=present command=droplet unique_name=yes name=$i" | sed -e 's/localhost | SUCCESS => //' | $JQ '.droplet.networks.v4[] | select(.type == "public") | .ip_address' | cut -f2 -d'"')
    echo "$i ansible_host=$IP" >> ${INVENTORY}/generated
  done
fi

echo "All done !"
