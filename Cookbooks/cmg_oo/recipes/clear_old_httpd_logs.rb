#
# Cookbook Name:: cmg_oo
# Recipe:: clear_old_httpd_logs
#

rightscale_marker :begin

bash "run_create_db_users" do
  user "root"
  cwd "/root"
  code <<-EOH
  rm -rf /var/log/httpd/*_log-*
  EOH
end

rightscale_marker :end
