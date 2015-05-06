#
# Cookbook Name:: cmg_oo
# Recipe:: mod_rewrite
#

rightscale_marker :begin

link "/etc/httpd/mods-enabled/rewrite.load" do
  to "/etc/httpd/mods-available/rewrite.load"
end

service "httpd" do
  action :restart
end

rightscale_marker :end
