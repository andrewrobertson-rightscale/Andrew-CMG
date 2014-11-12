#
# Cookbook Name:: cmg_oo
# Recipe:: nfs_db_restore
#

rightscale_marker :begin

template "/root/nfs_db_restore.php" do
  source "nfs_db_restore.php.erb"
  owner "root"
  group "root"
  mode "0755"
  action :create
end

rightscale_marker :end
