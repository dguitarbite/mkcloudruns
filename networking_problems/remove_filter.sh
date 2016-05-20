#! /bin/bash

for n in `crowbar machines list | grep d52`;do ssh $n "sed -i -e 's/ovs-vsctl/#ovs-vsctl/g' /etc/neutron/rootwrap.d/openvswitch-plugin.filters;systemctl restart openstack-neutron-openvswitch-agent.service";done


