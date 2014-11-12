#
# Cookbook Name:: cmg_oo
# Recipe:: nfs_db_backup
#

rightscale_marker :begin

template "/root/nfs_db_backup.php" do
  source "nfs_db_backup.php.erb"
  owner "root"
  group "root"
  mode "0755"
  action :create
end

rightscale_marker :end
