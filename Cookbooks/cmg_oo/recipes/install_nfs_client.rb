#
# Cookbook Name:: cmg_oo
# Recipe:: install_nfs_client
#

rightscale_marker :begin

yum_package "nfs-utils" do
	action :install
end

yum_package "nfs-utils-lib" do
	action :install
end

rightscale_marker :end
