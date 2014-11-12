#
# Cookbook Name:: cmg_oo
# Recipe:: vhost_default
#

rightscale_marker :begin

template "/etc/httpd/sites-available/001-default" do
  source "001-default.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

link "/etc/httpd/sites-enabled/001-default" do
  to "/etc/httpd/sites-available/001-default"
end

file "/var/www/index.html" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end

file "/var/www/html/index.html" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end

rightscale_marker :end