#
# Cookbook Name:: cmg_oo
# Recipe:: mount_nfs_vhosts
#

rightscale_marker :begin

directory "/home/vhosts" do
  owner "root"
  group "root"
  mode "0775"
  recursive true
  action :create
end

mount "/home/vhosts" do
  device "ec2-54-88-8-232.compute-1.amazonaws.com:/CMGSites/CMGVolume/vhosts"
  fstype "nfs"
  options [
  	"nfsvers=3",
  	"tcp",
  	"nolock"
  ]
end

directory "/mnt/efs" do
  owner "root"
  group "root"
  mode "0777"
  recursive true
  action :create
end

execute "mount efs" do
  command "mount -t nfs4 -o nfsvers=4.1 $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone).fs-9515d2dc.efs.us-east-1.amazonaws.com:/ /mnt/efs"
  action :run
end

rightscale_marker :end
