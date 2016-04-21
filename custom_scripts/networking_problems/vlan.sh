#! /bin/bash

. ~/.openrc
net_id=`neutron net-create vlan_net --provider:network-type vlan --provider:physical_network physnet1 --provider:segmentation_id 111 | grep ' id' | awk '{print $4;}'` 

sleep 1

neutron subnet-create vlan_net 10.10.10.0/24

sleep 1

image=$(nova image-list | grep "ACTIVE" | awk '{print $2;}')
flavor=$(nova flavor-list | grep "tiny" | awk '{print $2;}')
nova boot --image "$image" --flavor "$flavor" --nic net-id=$net_id training2

