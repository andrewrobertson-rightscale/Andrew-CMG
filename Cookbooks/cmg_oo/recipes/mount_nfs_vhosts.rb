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
  device "softnas:/CMG_OO/OO_SharedVolume/vhosts"
  fstype "nfs"
  options [
  	"nfsvers=3",
  	"tcp",
  	"nolock"
  ]
end

rightscale_marker :end
