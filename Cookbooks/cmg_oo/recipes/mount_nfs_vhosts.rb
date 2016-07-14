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

rightscale_marker :end
