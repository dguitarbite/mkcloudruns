#! /bin/bash

. ~/.openrc
image=$(nova image-list | grep "ACTIVE" | awk '{print $2;}')
instance_id=$(nova boot --image "$image" --flavor 1 training1 | grep ' id' | awk '{print $4;}')
sleep 1
port_ip=`nova show $instance_id | grep 'fixed' | awk '{print $5;}'`
port_id=`neutron port-list | grep "$port_ip" | awk '{print $2;}'`
floating_id=`neutron floatingip-create floating | grep ' id' | awk '{print $4;}'`
neutron floatingip-associate $floating_id $port_id
