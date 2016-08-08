#
# Cookbook Name:: cmg_oo
# Recipe:: global_php
#

rightscale_marker :begin

template "/mnt/efs/vhosts/_GLOBAL.php" do
  source "_GLOBAL.php.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

rightscale_marker :end
