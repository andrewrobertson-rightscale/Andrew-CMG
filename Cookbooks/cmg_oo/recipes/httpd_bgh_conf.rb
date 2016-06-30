#
# Cookbook Name:: cmg_oo
# Recipe:: httpd_bgh_conf
#

rightscale_marker :begin

template "/etc/httpd/conf/httpd.conf" do
  source "httpd_bgh.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

rightscale_marker :end
