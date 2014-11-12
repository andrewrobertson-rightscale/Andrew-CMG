#
# Cookbook Name:: cmg_oo
# Recipe:: nfs_db_backup_run
#

rightscale_marker :begin

bash "nfs_db_backup_run" do
  user "root"
  cwd "/root"
  code <<-EOH
  	./nfs_db_backup.php
  EOH
end

rightscale_marker :end
