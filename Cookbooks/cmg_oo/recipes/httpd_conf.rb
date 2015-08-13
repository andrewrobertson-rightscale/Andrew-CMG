#
# Cookbook Name:: cmg_oo
# Recipe:: httpd_conf
#

rightscale_marker :begin

template "/etc/httpd/conf/httpd.conf" do
  source "httpd.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

rightscale_marker :end
