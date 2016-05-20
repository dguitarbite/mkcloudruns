MkCloud Runs
------

# Description

Run multiple instances of mkcloud in parallel. I had a few months to
think about the format for this repository. Since this repository is
solely created to eliminate the boilerplate required for mkcloud.config,
and make it simpler to run multiple mkclouds in parallel with the logic
figured out, this should make it easier for developers to simply deploy
the required cloud with most common variables as comments.

The different cloudruns are most common scenarios.

Inspiration
> I'm just too lazy.

# Usage:

Simply copy the template folder and create a new one with the given number.
Check out the scripts, I will update the readme once I get more time for the same!
Please contact me on IRC freenode on #openstack/#openstack-doc/#opensuse channels if in doubt
or write me an email ...

``$ ./deployClouds``


# Deploying SUSE CLoud

Follow these steps to deploy the required SUSE Cloud setup.

## Initial Setup

* Clone the repository
* Setup up libvirt, KVM,LVM as per the automation repo, follow (this link)[https://github.com/dguitarbite/automation/blob/master/docs/mkcloud.md]
* Create a LVM drive either using dd or give it one partition from your disk
drive.
* Create PV and LV and give the LV name in the config file. Default is `mkcloudruns`.

### Libvirt

* Check if `libvirtd` is running and if it isn't start it.

  ```
  $ sudo service libvirtd status # to check the status
  $ sudo service libvirtd start  # to start the daemon
  ```

  It's recommended to configure libvirtd to start on boot.

  * For systems running systemd:
    ```
    $ sudo systemctl enable libvirtd
    ```

  * For systems running SysV:
    ```
    $ sudo chkconfig libvirtd on
    ```

* Turn off the firewall, otherwise there are going to be conflicts with the
  rules added by `libvirt`.

  ```
  $ sudo service SuSEfirewall2 stop
  ```

  Disable the firewall service to prevent it from starting on boot.

  * Using systemd:
    ```
    $ sudo systemctl disable SuSEfirewall2
    ```
  * Using SysV:
    ```
    $ sudo service SuSEfirewall2 off
    ```

### Setup storage for mkcloud.

#### Using file as a disk.

*Note:* Skip this step if you have a dedicated partition or disk for LVM.

To use mkcloud the following additional steps are needed:

* Create a disk file where the virtual machines are going to be stored. The
  minimum recommended is 80 GB.

  ```
  $ fallocate -l 80G mkcloud.disk
  ```

* Attach the created disk file to a loop device

  ```
  $ sudo losetup -f mkcloud.disk
  ```

* Check the location of the loop device. Something like `/dev/loop0`.
  ```
  $ sudo losetup
  ```

* Set the `cloudpv` variable in (mkcloudrun)[mkcloudrun] script for using this disk.
  - Ex: export cloudpv=/dev/loop0
  - Replace /dev/loop0 with your LVM partition if you want to use a dedicated PV.


##Deploy SUSE Cloud

* Configure storage options in the (mkcloudrun)[mkcloudrun] script. Read the comments under LVM.
* Go to the required folder and run the script `*.mkcloud*`.
* Ex.:
    ```
    $cd DevelCloud5/
    $sudo ./DevelCloud5.mkcloud1 plain
    ```
* Monitor the VMs via. virt-manager or virsh. Virt-manager should give you a GUI and easier to use for new users.
* After the deployment access the dashboards:
  - Crowbar/Admin Dashboard:
    + URL: `http://192.168.52.10:3000` *For DevelCloud5.mkcloud1 only*
    + User: `crowbar` Pass: `crowbar`
  - OpenStack Dashboard:
    + URL: `http://192.168.52.81` *For DevelCloud5.mkcloud1 only*
    + Admin User: `admin` Pass: `crowbar`
    + OpenStack User: `crowbar` Pass: `crowbar`

##Parallel Mkclouds

* To find out the required IP addresses of the mkcloud steup, go through the
  mkcloudrun file in this folder. Usually the formual is good to guess the
required IP addresses.
* Crowbar admin IP is at xxx.10.
* Ex: For `*.mkcloud5` the ip for admin node is 192.168.60.10

##RoadMap

* Add manual hostname entires to /etc/hosts for different cloud deployments.
* Add cleanup functionality.
