for i in {1..15};
do 
  echo $i
  net_node=`ssh root@crowbar.c$((i)) crowbar machines aliases list | grep "net" | awk '{print $1;}'`
  ssh root@crowbar.c$((i)) "ssh $net_node 'vconfig add eth0 111'"
  ssh root@crowbar.c$((i)) "ssh $net_node 'ip link set eth0.111 up'"
done
