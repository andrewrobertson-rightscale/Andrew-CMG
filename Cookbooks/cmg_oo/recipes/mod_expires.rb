#
# Cookbook Name:: cmg_oo
# Recipe:: mod_expires
#

rightscale_marker :begin

link "/etc/httpd/mods-enabled/expires.load" do
  to "/etc/httpd/mods-available/expires.load"
end

service "httpd" do
  action :restart
end

rightscale_marker :end
