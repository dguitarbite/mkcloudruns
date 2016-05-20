#! /bin/bash

for i in {1..15};
do 
  ssh root@crowbar.c$((i)) 'bash -s' < remove_filter.sh ;done;
done

