#
# Cookbook Name:: cmg_oo
# Recipe:: etc_hosts
#

rightscale_marker :begin

template "/etc/hosts" do
  source "etc_hosts.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

rightscale_marker :end
