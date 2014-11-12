#
# Cookbook Name:: cmg_oo
# Recipe:: nfs_db_backup_cron
#

rightscale_marker :begin

cron "nfs_db_backup_cron" do
  minute "00"
  hour "03"
  mailto "rchristy@carbonmediagroup.com"
  command "cd /root && ./nfs_db_backup.php"
  action :create
end

rightscale_marker :end
