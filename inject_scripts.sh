# Send the names of the scripts as the environment variables to copy over the required/given scripts.

for i in {1..15};
do
  net_admin=192.168.$((50+$n*2)).10
  scp "$@" root@$net_admin:/root/. ;
  # ssh root@$net_admin "for script in $@:; do bash $script; done";
done

# Note: For running the scripts after injecting them, just uncomment the given line in the for loop block.
