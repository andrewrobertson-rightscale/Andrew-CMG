#
# Cookbook Name:: cmg_oo
# Recipe:: clear_old_httpd_logs
#

rightscale_marker :begin

bash "clear_old_logs" do
  user "root"
  cwd "/root"
  code <<-EOH
  rm -rf /var/log/httpd/*_log-*
  EOH
end

rightscale_marker :end
