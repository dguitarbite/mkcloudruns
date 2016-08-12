for i in {1..15};
do
  echo $i 
  #scp "$@" root@crowbar.c$((i)):/root/. ;
  first_node=`ssh root@crowbar.c$((i)) crowbar machines list | grep 01`
  ssh root@crowbar.c$((i)) ssh $first_node 'bash -s' < "$@"
done
